from asyncio import sleep
import asyncio
import json
import pathlib
import subprocess
import sys
from fastapi.responses import FileResponse, JSONResponse
import tempfile

def user_access(lic):
   return f"""

   define ns if not exists airportal;
   use ns airportal;
   define db if not exists testing;
   use db airportal;

    DEFINE ACCESS userAccessToken
    ON DATABASE
    TYPE JWT
    ALGORITHM RS256
    KEY "{lic}";
  
  
""".strip()


def create_business(business: dict):
   return f"""

   use ns airportal;
   use db airportal;

    create business content {{
    name: "{business["name"]}",
    address: "{business["address"]}",
    contacts: {business["contacts"]},
    logo: "deflogo.png",
    }};
    
  
  
""".strip()



async def initialize():
    OS_NAME = sys.platform

    if getattr(sys, 'frozen', False):
        HOME_PATH = pathlib.Path(sys.executable).parent
    else:
        HOME_PATH = pathlib.Path(__file__).parent.absolute()


    db_folder = f"surrealkv:{HOME_PATH.absolute().joinpath("__db__")}"
    dbExe = pathlib.Path(f"{HOME_PATH}/db")

    lic = f"{HOME_PATH.absolute().joinpath("license")}"
    with open(lic) as f:
        license = f.read()

    
    # Start SurrealDB with the initialization script
    with tempfile.NamedTemporaryFile(mode="w+", delete=False, delete_on_close=False, suffix=".surql") as file:
        file.write(user_access(license))
        file.flush() 
        file.seek(0)  
        filePath = pathlib.Path(file.name).absolute()


        proc = subprocess.Popen(
            [dbExe, "start", db_folder, "-b", "0.0.0.0:4444", "-u", "root", "-p", "root", "--import-file", filePath]
        )

    schema_path = HOME_PATH.absolute().joinpath("schema")
    await asyncio.sleep(2)


    conn = None
    if OS_NAME == "Windows":
        conn = "http://localhost:4444"
    else:
        conn = "http://0.0.0.0:4444"

    print("os: ", OS_NAME)    

    subprocess.Popen([dbExe, 
        "import", "--conn", conn, "-u", "root", "-p", "root", "--ns", "airportal", "--db", "airportal",
        schema_path.absolute().joinpath("schema.surql")
        ])

    
    await asyncio.sleep(2)
    print("schema done")
    
    subprocess.Popen([dbExe,
        "import", "--conn", conn, "-u", "root", "-p", "root", "--ns", "airportal", "--db", "airportal",
        schema_path.absolute().joinpath("resources.surql")
        ])
    
    await asyncio.sleep(2)
    print("flows done")
    
    subprocess.Popen([dbExe,
        "import", "--conn", conn, "-u", "root", "-p", "root", "--ns", "airportal", "--db", "airportal",
        schema_path.absolute().joinpath("initialization.surql")
        ])
    
    
    await asyncio.sleep(2)
    print("initialization done")
    
    await sleep(5)
    pathlib.Path(file.name).unlink(missing_ok=True)  # Manually delete if needed
    
    print("initialized")


    print("======= creating business =======")

    with open("bdata") as bdf:
        dt = json.loads(bdf.read())
        

    
    with tempfile.NamedTemporaryFile(mode="w+", delete=False, delete_on_close=False, suffix=".surql") as bdf:
        bdf.write(create_business(dt))
        bdf.flush() 
        bdf.seek(0)  
        filePath = pathlib.Path(bdf.name).absolute()


        subprocess.Popen([dbExe,
        "import", "--conn", conn, "-u", "root", "-p", "root", "--ns", "airportal", "--db", "airportal",
            filePath
        ])

    await asyncio.sleep(2)
    pathlib.Path(bdf.name).unlink(missing_ok=True)  # Manually delete if needed





    print("======= created business =======")

    await asyncio.sleep(3)


    proc.kill()
    raise SystemExit("Server shutdown triggered by /shutdown")

