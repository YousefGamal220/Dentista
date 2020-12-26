from Verifications import Validator
from flask import request
from SQLAPI import SQL
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Store

def Store_insertion():
    columns = [ 'Store_Name', 'Email', 'Password', 'Phone_Number', 'Credit_Card_Number']
    values = []
    for key in columns:
        values.append(request.json[key])
    connector = SQL(host=server_name, user=server_admin)
    connector.insert_query(table = 'STORE', attributes=columns, values=values)
    connector.close_connection()
    return "1"

# --------------------------------------------------------------------------------------------------------------------------------

# Validations of the Store




def Store_email_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.email_validation('Email')

def Store_phone_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.phone_validation('Phone_Number')

# -----------------------------------------------------------------------------------------------------------------------------------------
