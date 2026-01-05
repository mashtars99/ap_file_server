import sys
import pathlib
import subprocess
import asyncio
from asyncio import sleep
from surrealdb import Surreal
import os
import shutil
import datetime
import psutil

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





def check_port_usage(port):
    # Iterate through all connections
    for conn in psutil.net_connections(kind='inet'):

        if conn.laddr.port == port and conn.status == 'LISTEN':
            pid = conn.pid
            process = psutil.Process(pid)
            return True, process.name(), pid  # Process is using the port
    return False, None, None  # No process is using the port




async def apply_migrations():
    OS_NAME = sys.platform

    if getattr(sys, 'frozen', False):
        HOME_PATH = pathlib.Path(sys.executable).parent
    else:
        HOME_PATH = pathlib.Path(__file__).parent.parent.absolute()

    db_folder = f"surrealkv:{HOME_PATH.absolute().joinpath("__db__")}"
    dbExe = pathlib.Path(f"{HOME_PATH}/db")

    try:
        subprocess.Popen(
            [dbExe, "start", db_folder, "-b", "0.0.0.0:4444", "-u", "root", "-p", "root"]
        )
    except:
        pass

    await asyncio.sleep(2)


    await migrate()

if __name__ == "__main__":
    import argparse

    # Create the parser
    parser = argparse.ArgumentParser()

    # Define the positional argument
    parser.add_argument("type", help="")

    # Parse the arguments
    args = parser.parse_args()

    if(args.type == "generate"):
        generate()
    elif(args.type == "apply"):
        asyncio.run(apply_migrations())
    

    


