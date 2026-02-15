import pickle

server = {
        "version": "0.3.0",
        "db": "2.4.0",
    }

with open("./config", "wb") as f:
    pickle.dump(server, f)