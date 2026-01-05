import sys
import pathlib
import subprocess
import asyncio
from asyncio import sleep
from surrealdb import Surreal
import os
import shutil
import datetime

async def migrate():
    # ASSUMES THE DB SERVER IS RUNNING.

    OS_NAME = sys.platform
    if getattr(sys, 'frozen', False):
        HOME_PATH = pathlib.Path(sys.executable).parent
    else:
        HOME_PATH = pathlib.Path(__file__).parent.parent.absolute()

    host = None
    if OS_NAME == "win32":
        host = "localhost:4444"
    else:
        host = "0.0.0.0:4444"

    print("os: ", OS_NAME)

    with Surreal(f"ws://{host}/rpc") as db:
        db.signin({"username": 'root', "password": 'root'})
        db.use("airportal", "airportal")

        done = db.query("select value version from migration;")
        migration_folder = HOME_PATH.absolute().joinpath("migrations") 

        migrations = []

        for fld in os.listdir(migration_folder):
            if not migration_folder.joinpath(fld).is_dir():
                continue
            migrations.append(int(fld))
    
           
        migrations.sort()

        for fld in migrations:
            if(fld in done):
                print("[IGNORED] ", fld)
                continue
            with open(migration_folder.joinpath(str(fld)) / "schema.surql") as f:
                schema = f.read()
            with open(migration_folder.joinpath(str(fld)) / "seeds.surql") as f:
                seeds = f.read()

            query = "begin transaction; \n" \
                    f"{schema} \n" \
                    f"{seeds} \n" \
                    f"create migration content {{version: {fld}}}; \n" \
                    "commit transaction;"
            
            db.query(query)

            
    
    print("migration done")



def generate() -> str:
    if getattr(sys, 'frozen', False):
        HOME_PATH = pathlib.Path(sys.executable).parent
    else:
        HOME_PATH = pathlib.Path(__file__).parent.parent.absolute()
    migration_folder = HOME_PATH.absolute().joinpath("migrations")

    version = 1
    for fld in os.listdir(migration_folder):
        if not migration_folder.joinpath(fld).is_dir():
            continue
        version += 1



    name = str(version)

    new_mg_folder = migration_folder.absolute() / name
    os.mkdir(new_mg_folder)


    with open(new_mg_folder.joinpath("schema.surql"), "w"):
        ...

    with open(new_mg_folder.joinpath("seeds.surql"), "w"):
        ...

    return name





if __name__ == "__main__":
    # asyncio.run(migrate())
    generate()
    ...
