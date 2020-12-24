from flask import Flask, jsonify, request

from SQLAPI import SQL
import json
import Dentist
import Manager
import Delivery
import Store2
import store
from validate_email import validate_email
import Login_Auth
from Verifications import Validator

app = Flask(__name__)



#------------------------------------------------------------------------------------------------------------------------------
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
#------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------
# Login

app.add_url_rule('/LogIn', view_func=Login_Auth.LogIn, methods = ['POST'])

#------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------
# Dentist 

app.add_url_rule('/dentist_signup', view_func=Dentist.dentist_insertion, methods = ['POST'])
app.add_url_rule('/dentist_email_validation', view_func=Dentist.dentist_email_validation, methods = ['POST'])
app.add_url_rule('/dentist_phone_validation', view_func=Dentist.dentist_phone_validation, methods = ['POST'])
app.add_url_rule('/dentist_creditcard_validation', view_func=Dentist.dentist_CreditCard_validation, methods = ['POST'])

#---------------------------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------------------------------
# Manager
app.add_url_rule('/manager_signup' , view_func=Manager.Manager_Insertion, methods=['POST'])
app.add_url_rule('/manager_email_validation' , view_func=Manager.Manager_email_validator , methods=['POST'])

#-----------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------

# Delivery
app.add_url_rule('/delivery_signup', view_func=Delivery.Delivery_insertion,methods=['POST'])
app.add_url_rule('/delivery_email_validation',view_func=Delivery.Delivery_email_validation,methods=['POST'])
app.add_url_rule('/delivery_phone_validation',view_func=Delivery.Delivery_PhoneNumber_validator,methods=['POST'])
app.add_url_rule('/delivery_creditcard_validation',view_func=Delivery.Delivery_CreditCard_validation,methods=['POST'])

#-----------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------
#For Store
app.add_url_rule('/Store_signup', view_func=store.Store_insertion,methods=['POST'])
app.add_url_rule('/Store_email_validation',view_func=store.Store_email_validation,methods=['POST'])
app.add_url_rule('/Store_phone_validation',view_func=store.Store_PhoneNumber_validator,methods=['POST'])
app.add_url_rule('/Store_creditcard_validation',view_func=store.Store_CreditCard_validation,methods=['POST'])
app.add_url_rule('/Store_Name_validation',view_func=store.Store_Name_validation,methods=['POST'])

app.add_url_rule('/Store2_signup', view_func=Store2.Store_insertion,methods=['POST'])
app.add_url_rule('/Store_ADDRESS_Validation',view_func=Store2.ADDRESS_validation ,methods=['POST'])
app.add_url_rule('/Store_CITY_validation',view_func=Store2.CITY_validation ,methods=['POST'])
app.add_url_rule('/Store_Region_validation',view_func=Store2.REGION_validation,methods=['POST'])
app.add_url_rule('/Store_ZIP_validation',view_func=Store2.ZIP_validation ,methods=['POST'])

def run_server(debug=False):
    app.run(debug=debug)

if __name__ == "__main__":
    run_server(debug=False)





