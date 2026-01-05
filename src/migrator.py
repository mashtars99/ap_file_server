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

        done = db.query("select value name from migration")
        migration_folder = HOME_PATH.absolute().joinpath("migrations") 

        migrations = []

        for fld in os.listdir(migration_folder):
            if not migration_folder.joinpath(fld).is_dir():
                continue

            migrations.append(
                datetime.datetime.fromisoformat(fld)
            )
    
           
        migrations.sort()
        migration_names = list(map(lambda x: str(x), migrations))

        for fld in migration_names:
            if(fld in done):
                continue
            with open(migration_folder.joinpath(fld) / "schema.surql") as f:
                schema = f.read()
            with open(migration_folder.joinpath(fld) / "seeds.surql") as f:
                seeds = f.read()

            query = "begin transaction; \n" \
                    f"{schema} \n" \
                    f"{seeds} \n" \
                    f"create migration content {{name: '{fld}'}}; \n" \
                    "commit transaction;"
            
            db.query(query)
            
    
    print("migration done")



def generate() -> str:
    if getattr(sys, 'frozen', False):
        HOME_PATH = pathlib.Path(sys.executable).parent
    else:
        HOME_PATH = pathlib.Path(__file__).parent.parent.absolute()
    now = datetime.datetime.now(datetime.timezone.utc)
    name = str(now)

    migration_folder = HOME_PATH.absolute().joinpath("migrations")
    new_mg_folder = migration_folder.absolute() / name
    os.mkdir(new_mg_folder)


    with open(new_mg_folder.joinpath("schema.surql"), "w"):
        ...

    with open(new_mg_folder.joinpath("seeds.surql"), "w"):
        ...

    return name





if __name__ == "__main__":
    asyncio.run(migrate())
