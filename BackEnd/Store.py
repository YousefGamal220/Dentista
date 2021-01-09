from Verifications import Validator
from flask import request
from SQLAPI import SQL
import json
# ------------------------------------------------------------------------------------------------------------------------------
# Connection Arguments of the database
server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
# --------------------------------------------------------------------------------------------------------------------------------

# Insertion of the Store

def Store_insertion():
    columns = [ 'STORE_NAME', 'EMAIL', 'PASSWORD', 'PHONE_NUMBER', 'CREDIT_CARD_NUMBER']
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
    return validator.email_validation('EMAIL')

def Store_phone_validation():
    validator = Validator(connection_details, 'STORE')
    return validator.phone_validation('PHONE_NUMBER')

# -----------------------------------------------------------------------------------------------------------------------------------------
def Store_Information():
    columns = ['STORE_NAME','EMAIL','PHONE_NUMBER' ,'CREDIT_CARD_NUMBER']
    ID = request.json['ID']
    connector = SQL(host=server_name, user=server_admin)
    condition = " STORE_ID ='" + ID+ "' and MANAGER_ID "
    Count_Region = connector.select_query(table='store_branch ',columns= ['count(STORE_ID)'],sql_condition=condition)
    Region = connector.select_query(table='store_branch ',columns= ['REGION'],sql_condition=condition)
    condition = " STORE_ID ='" + ID+ "' "
    result = connector.select_query(table='STORE ',columns=columns,sql_condition=condition)
    result = {'STORE_NAME': result['STORE_NAME'],'EMAIL': result['EMAIL'],'PHONE_NUMBER': result['PHONE_NUMBER'], 'CREDIT_CARD_NUMBER': result['CREDIT_CARD_NUMBER'], 'Count_Branches': Count_Region['count(STORE_ID)'], 'BRANCHES': Region['REGION']}
    connector.close_connection()
    return json.dumps(result)

# ------------------------------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------------------------------------------------------

def Update_Store_table():
    columns_dic = request.json['dic']
    ID = request.json["ID"]
    condition = "STORE_ID = '" +str(ID) +  "'"
    connector = SQL(host=server_name, user=server_admin)
    connector.update_query(table='STORE' ,columns_values_dict= columns_dic,sql_condition=condition)
    connector.close_connection()
    return "1"

