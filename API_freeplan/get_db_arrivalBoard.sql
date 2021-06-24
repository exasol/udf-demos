--/
CREATE OR REPLACE PYTHON3 SCALAR SCRIPT get_db_arrivalBoard(id DECIMAL)
EMITS (train VARCHAR(200), train_type VARCHAR(10), dateTime VARCHAR(20), origin VARCHAR(40), track VARCHAR(20)) AS

import urllib.request as request
import json
import datetime as dt
       
def run(ctx):
        id = ctx.id
        today = dt.date.today().strftime("%Y-%m-%d")
        url = f" https://api.deutschebahn.com/freeplan/v1/arrivalBoard/{id}?date={today}"

        with request.urlopen(url) as response:
                if response.getcode() == 200:
                        source = response.read()
                        data = json.loads(source)

                        # --loop over each record
                        for line in data:
                                ctx.emit(line.get("name", ""), line.get("type", ""), line.get("dateTime", ""), line.get("origin", ""), line.get("track", ""))
                else:
                        print("An error occured when trying to reach out to API")

/



