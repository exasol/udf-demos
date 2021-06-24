--/
CREATE OR REPLACE PYTHON3 SCALAR SCRIPT html_unescape(input_value VARCHAR(2000))
RETURNS VARCHAR(2000) AS
#-- this script does convert html escaped characters back to human readable characters (i.e. #x028; to ")")
import html
       
def run(ctx):
        return html.unescape(ctx.input_value)

/

