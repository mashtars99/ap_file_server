import pickle


with open("config", "wb") as f:
    pickle.dump({
        "airportal_version": "0.0.1",
        "db_version": "2.3.7",
        "server_version": "0.0.1"
    }, f)