import asyncio
import pathlib
import subprocess
import os
import shutil




def create_or_replace_folder(path):
    if os.path.exists(path):
        shutil.rmtree(path)  # Delete the existing folder and all its contents
    os.makedirs(path)        # Create the new folder




async def genereate():
    create_or_replace_folder("./schema")
    await asyncio.sleep(1)  # Ensure the folder is created before proceeding

    HOME_PATH = pathlib.Path(__file__).parent.absolute()
    dbExe = pathlib.Path(f"{HOME_PATH}/db")

    args = [dbExe, "export", "--conn", "http://0.0.0.0:4444",
             "-u", "root",
               "-p", "root", "--namespace", "airportal", "--database", "airportal", ]
    subprocess.Popen(
               args + [ 
                   "--functions", "true", "--accesses", 'false', "--only", 
                   "./schema/resources.surql"]
            )
    
    await asyncio.sleep(1)

    subprocess.Popen(
                args + ["--tables", "true", "--only", "./schema/schema.surql"]
            )
    await asyncio.sleep(1)
    
    

if __name__ == "__main__":
    asyncio.run(genereate())
    print("done")