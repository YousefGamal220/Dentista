from SQLAPI import SQL
from flask import request

# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

def LogIn():
    email = request.json['email']
    password = request.json['password']
    sql = SQL(server_name,server_admin, server_password)
    condition = "email = '" +email + "' and password = '" + password + "'"
    result = sql.select_query(table = 'LOGIN_DATA', columns=['AccountType'], sql_condition=condition)
    sql.close_connection()
    if result['AccountType'] == {}:
        return 'None'
    return result['AccountType'][0]