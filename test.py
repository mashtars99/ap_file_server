import json


with open("airports.json") as bdf:
    dt = json.loads(bdf.read())

result = []
for ar in dt["airportsListModels"]:
    result.append(
        {
            "airport_name": ar["airportName"],
            "airport_code": ar["airportCode"],
            "country_name": ar["country"],
            "country_code": ar["countryCode"],
            "country_long_code": ar["countryCodeLong"],
            "airport_description": ar["description"],
            "latitude": ar["latitude"],
            "longitude": ar["longitude"],
        }
    )


with open("new_airports.json", "w") as f:
    json.dump(result, f)