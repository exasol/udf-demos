--/
CREATE OR REPLACE PYTHON3 SCALAR SCRIPT get_db_location(name VARCHAR(2000))
EMITS (name VARCHAR(200), lon float, lat float, id decimal) AS

import urllib.request as request
import json
import datetime as dt
       
def run(ctx):
        name = ctx.name.replace(chr(32), "%20")
        url = f"https://api.deutschebahn.com/freeplan/v1/location/{name}"

        with request.urlopen(url) as response:
                if response.getcode() == 200:
                        source = response.read()
                        data = json.loads(source)

                        # --loop over each record
                        for line in data:
                                ctx.emit(line["name"], line["lon"], line["lat"], line["id"])
                else:
                        print("An error occured when trying to reach out to API")

/

