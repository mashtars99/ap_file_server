from asyncio import sleep
import asyncio
import json
import pathlib
import subprocess
import sys
from fastapi.responses import FileResponse, JSONResponse
import tempfile
from migrator import migrate

from surrealdb import Surreal

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

    // migrations
    define table migration schemaless type normal permissions none;
    define field name on migration type string assert string::len($value) > 0;

    define index unique_migration on migration fields name unique;
  
  
""".strip()



async def initialize():
    OS_NAME = sys.platform

    if getattr(sys, 'frozen', False):
        HOME_PATH = pathlib.Path(sys.executable).parent
    else:
        HOME_PATH = pathlib.Path(__file__).parent.parent.absolute()

    print(HOME_PATH)

    db_folder = f"surrealkv:{HOME_PATH.absolute().joinpath("__db__")}"
    dbExe = pathlib.Path(f"{HOME_PATH}/db")

    lic = f"{HOME_PATH.absolute().joinpath("license")}"
    with open(lic) as f:
        license = f.read()


    proc = subprocess.Popen(
        [dbExe, "start", db_folder, "-b", "0.0.0.0:4444", "-u", "root", "-p", "root"]
    )

    await asyncio.sleep(2)


    with Surreal(f"ws://0.0.0.0:4444/rpc") as db:
        db.signin({"username": 'root', "password": 'root'})
        db.query(user_access(license))

    await asyncio.sleep(2)

    await migrate()


    print("initialized")


    await asyncio.sleep(2)


    proc.kill()
    raise SystemExit("Server shutdown triggered by /shutdown")

