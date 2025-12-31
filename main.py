from asyncio import sleep
import asyncio
from io import BytesIO
import tempfile
from typing import Annotated, Optional
import uuid
import zipfile
from fastapi import FastAPI, HTTPException, Query, Form
from fastapi import UploadFile
from fastapi.staticfiles import StaticFiles
import uvicorn
import pathlib
import subprocess
from fastapi.responses import FileResponse, JSONResponse, StreamingResponse
from fastapi.templating import Jinja2Templates
import pickle
from fastapi import Request,File,Form
import signal
import platform
import atexit
import os
import initialize

from docxtpl import DocxTemplate, InlineImage
from docx.shared import Mm
import json



HOME_PATH = None
surreal_process = None
OS_NAME = platform.system()

app = FastAPI()

doc_viewer = FastAPI()


templates = Jinja2Templates(directory="docviewer")
app.mount("/docviewer", doc_viewer, name="react")
doc_viewer.mount("/assets", StaticFiles(directory="./docviewer/assets", html=True), name="docviewer")



@doc_viewer.get("/")
async def _doc_index(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@doc_viewer.get("/files/{id}")
async def _get_file(id: str): 
    if not id or id.strip() == "":
        raise HTTPException(status_code=400, detail="Missing or empty 'id' parameter.")

    
    try:
        obj = f"{HOME_PATH}/__files__/{id}"
        if not pathlib.Path(obj).exists():
            raise HTTPException(status_code=404)
        return FileResponse(obj)
    except:
        raise HTTPException(status_code=404)

# @doc_viewer.post("/upload")
# async def _veiw(fl: UploadFile):
#     try:
#         name_ext = fl.filename.split(".")
#         iid = uuid.uuid4().hex
#         if len(name_ext) >= 2:
#             *_, ext = name_ext
#             name = iid + f".{ext}"
#         else:
#             name = iid

#         with open(f"{HOME_PATH}/docviewer/files/{name}", "wb") as f:
#             f.write(fl.file.read())
#         return {"id": name}

#     except Exception as e:
#         print("errro: ", e)
#         raise HTTPException(status_code=500)
    

@doc_viewer.post("/get-vars")
async def _get_vars(fl: UploadFile):

    doc = DocxTemplate(fl.file)

    vars = doc.get_undeclared_template_variables()

    return {"vars": vars}

    

@app.post("/generate-doc")
async def _genereate_doc(
    template: Annotated[str, Form()],
    data: Annotated[str, Form()], 
    images: Optional[list[UploadFile]] = File(default=[]) 
    ):            
    temp = DocxTemplate("./__files__/"+template)


    data: dict = json.loads(data)
    context = {}

    for d in data.items():
        var, val = d
        if(val["type"] != "image"):
            context[var] = val["value"]


    imgs = []

    if images:
        for d in data.items():
            var, val = d
            if(val["type"] == "image"):
                for img in images:
                    if img.filename == val["filename"]:
                        imgs.append((var, img, val))

    for d in imgs:
        var, img, val = d
        inl_img = InlineImage(temp, img.file, width=Mm(float(val["width"] or 0)), height=Mm(float(val["height"] or 0)))
        context[var] = inl_img

    
    temp.render(context)

    
    buffer = BytesIO()
    temp.save(buffer)
    buffer.seek(0)

    # Return DOCX as download
    return StreamingResponse(
        buffer,
        media_type="application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        headers={
            "Content-Disposition": f"attachment; filename=generated.docx"
        }
    )

    


@app.post("/upload")
async def upload(fl: UploadFile):
    try:
        name_ext = fl.filename.split(".")
        iid = uuid.uuid4().hex
        if len(name_ext) >= 2:
            *_, ext = name_ext
            name = iid + f".{ext}"
        else:
            name = iid

        with open(f"{HOME_PATH}/__files__/{name}", "wb") as f:
            f.write(fl.file.read())
        return {"id": name}

    except Exception as e:
        print("errro: ", e)
        raise HTTPException(status_code=500)


@app.get("/download")
async def download_media(id: Annotated[str, Query()]):

    if not id or id.strip() == "":
        raise HTTPException(status_code=400, detail="Missing or empty 'id' parameter.")

    
    try:
        obj = f"{HOME_PATH}/__files__/{id}"
        if not pathlib.Path(obj).exists():
            raise HTTPException(status_code=404)
        return FileResponse(obj)
    except:
        raise HTTPException(status_code=404)
    
@app.post("/delete")
async def download_media(id: Annotated[str, Query()]):

    if not id or id.strip() == "":
        raise HTTPException(status_code=400, detail="Missing or empty 'id' parameter.")

    
    try:
        obj = f"{HOME_PATH}/__files__/{id}"
        if not pathlib.Path(obj).exists():
            raise HTTPException(status_code=404)
        else:
            os.remove(obj)

        return {"message": "deleted", "id": id}
    except:
        raise HTTPException(status_code=404)


@app.get("/status")
async def status(code: str):
    if code != "airportal_check_code":
        return JSONResponse({"message": "forbidden"}, content=403)
    return {
        "server_status": "up",
        "db": "up" if surreal_process is not None and surreal_process.poll() is None else "down",
        "server_payload": {},
    }

@app.post("/shutdown")
async def shutdown_server(code):
    if code != "airportal_check_code":
        return JSONResponse({"message": "forbidden"}, content=403)
    
    asyncio.create_task(shutdown())

    return {"message": "Server is shutting down..."}


async def shutdown():
    # Here you can clean up the resources and do the necessary tasks
    print("Shutting down the server...")
    
    # Wait a bit before actually shutting down, just to ensure response is sent
    await asyncio.sleep(1)

    # Now trigger the server shutdown
    raise SystemExit("Server shutdown triggered by /shutdown")

@app.post("/backup")
async def backup(file_path: str):
    ...




def load_config():
    path = pathlib.Path("./config").absolute()
    
    with open(path, "rb") as f:
        content = pickle.load(f)
    return content


def cleanup():
    if surreal_process and surreal_process.poll() is None:
        print("Shutting down db...")
        surreal_process.terminate()
        try:
            surreal_process.wait(timeout=5)
        except subprocess.TimeoutExpired:
            surreal_process.kill()


def handle_signal(signum, frame):
    cleanup()
    sys.exit(0)






if __name__ == "__main__":
    import sys
    import argparse


    parser = argparse.ArgumentParser("file server")
    parser.add_argument("--init", default=False)
    parser.add_argument("--port", default=9900)

    args = parser.parse_args()

    atexit.register(cleanup)
    signal.signal(signal.SIGINT, handle_signal)
    signal.signal(signal.SIGTERM, handle_signal)

    try:

        if(args.init):
            asyncio.run(initialize.initialize())
        else:
            if getattr(sys, 'frozen', False):
                HOME_PATH = pathlib.Path(sys.executable).parent
            else:
                HOME_PATH = pathlib.Path(__file__).parent.absolute()

            path = f"surrealkv:{HOME_PATH.absolute().joinpath("__db__")}"
            config = load_config()

            dbExe = pathlib.Path(f"{HOME_PATH}/db")
            
            surreal_process = subprocess.Popen(
                [dbExe, "start", path, "-b", "0.0.0.0:4444", "-u", "root", "-p", "root"]
            )
            uvicorn.run(app, host="0.0.0.0", port=9900)
    except Exception as e:
        print("err: ", e)
        sys.exit(1),
