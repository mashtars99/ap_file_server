import subprocess
import os
import asyncio
import shutil
import sys
import pickle


async def main():
    OS_NAME = sys.platform
    subprocess.run(["uv", "run", "pyinstaller", "src/main.py", "--onefile"])

    subprocess.run(["uv", "run", "pyinstaller", "src/migrator.py", "--onefile", "--name", "migrator.exe"])

    if(os.path.exists("./deploy")):
        shutil.rmtree("./deploy")

    os.mkdir("./deploy")
    os.mkdir("./deploy/__files__")

    if(OS_NAME == "win32"):
        shutil.copy2("./db.exe", "./deploy")
    else:
        shutil.copy2("./db", "./deploy")


    shutil.copy2("./dist/main.exe", "./deploy/fs.exe")
    shutil.copytree("./migrations", "./deploy/migrations")
    shutil.copytree("./docviewer", "./deploy/docviewer")


    shutil.copy2("./dist/migrator.exe", "./deploy/migrator.exe")

    server = {
        "version": "0.3.0",
        "db": "2.4.0",
    }

    with open("./deploy/config", "wb") as f:
        pickle.dump(server, f)






asyncio.run(main())


