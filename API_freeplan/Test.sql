/*
Please bear in mind, that the free version of the API is restricted to maximum 10 calls per minute...
If you register at the website to get your own key, you would be granted full access
*/

-- simply use the udf name in the select clause.
select get_db_location('Nuernberg');

-- you can then use your prefered id to call the arrival board.
select get_db_arrivalboard(8000284);

-- you can even reuse a result set from one api call to a second one.
-- BUT: you will have to materialize the result. Therefore you can use the WITH clause, as you can see here:

with location as
        (select get_db_location('Nuernberg') limit 1)
, arrival as 
        (select id, name, get_db_arrivalboard(id) from location)
select id, name, train, train_type, datetime, origin, track 
, html_unescape(origin) origin_neu
from arrival
where train_type='IC'        
