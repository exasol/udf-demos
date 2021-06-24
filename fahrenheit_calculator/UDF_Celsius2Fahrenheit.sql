/*
Those two functions are very straight forward and very simple.
It's purpose is to demonstrate how easy and simple it is to use a python function in Exasol.
And as you can see the overhead is quite minimal
*/

/* Generate Test data */
CREATE TABLE "TEMPERATURE" ("TEMP_FAHRENHEIT" DOUBLE, "TEMP_DATE" CHAR(10));
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (5.0, '2099-01-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (32.0, '2099-02-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (50.0, '2099-03-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (68.0, '2099-04-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (77.0, '2099-05-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (95.0, '2099-06-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (104.0, '2099-07-01');
INSERT INTO  "TEMPERATURE" ("TEMP_FAHRENHEIT", "TEMP_DATE") VALUES (114.8, '2099-08-01');

/* Generate Script */
CREATE OR REPLACE PYTHON3 SCALAR SCRIPT celsius2fahrenheit(input_value double)
RETURNS double AS

def run(ctx):
        return (ctx.input_value * 9 / 5 ) + 32

/

CREATE OR REPLACE PYTHON3 SCALAR SCRIPT fahrenheit2celsius(input_value double)
RETURNS double AS

def run(ctx):
        return (ctx.input_value - 32) * 5 / 9

/

/* Test */

select temp_fahrenheit
       , fahrenheit2celsius(temp_fahrenheit) temp_celsius  
       , celsius2fahrenheit(fahrenheit2celsius(temp_fahrenheit)) temp_fahrenheit_test  
       , temp_date
from temperature;