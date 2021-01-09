from flask import Flask, jsonify, request

from SQLAPI import SQL
import json
import Dentist
import Manager
import Delivery
import Store2
import Store
from validate_email import validate_email
import Login_Auth
from Verifications import Validator
import Add_Item
import DentistProduct
import DentistComments
import Cart
app = Flask(__name__)



'''
server_name = "dentista1.mysql.database.azure.com"
server_admin = "dentista@dentista1"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
'''

server_name = "localhost"
server_admin = "root"
server_password = "@dentist1"
database = "DENTISTA"
connection_details = [server_name, server_admin, server_password, database]
#------------------------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------------------------
# Login

app.add_url_rule('/LogIn', view_func=Login_Auth.LogIn, methods = ['POST'])
app.add_url_rule('/GetData', view_func=Login_Auth.GetName, methods = ['GET', 'POST'])

#------------------------------------------------------------------------------------------------------------------------------


#-------------------------------------------------------------------------------------------------------------------------------
# Dentist 

app.add_url_rule('/dentist_signup', view_func=Dentist.dentist_insertion, methods = ['POST'])
app.add_url_rule('/dentist_email_validation', view_func=Dentist.dentist_email_validation, methods = ['POST'])
app.add_url_rule('/dentist_phone_validation', view_func=Dentist.dentist_phone_validation, methods = ['POST'])
app.add_url_rule('/dentist_creditcard_validation', view_func=Dentist.dentist_CreditCard_validation, methods = ['POST'])
app.add_url_rule('/GetDentist', view_func=Dentist.GetDentist, methods = ['POST'])

#---------------------------------------------------------------------------------------------------------------------------------



#-----------------------------------------------------------------------------------------------------------------------------------
# Manager
app.add_url_rule('/manager_signup' , view_func=Manager.Manager_Insertion, methods=['POST'])
app.add_url_rule('/manager_email_validation' , view_func=Manager.Manager_email_validator , methods=['POST'])
app.add_url_rule('/manager_update', view_func=Manager.Update_Manager_table, methods = ['POST'])
app.add_url_rule('/pending_requests', view_func=Manager.Get_Pending_Requests, methods = ['GET'])
app.add_url_rule('/get_Delivery_info', view_func=Manager.Get_Request_Info_Delivery, methods = ['POST'])
app.add_url_rule('/get_all_stores', view_func=Manager.Get_All_Stores, methods = ['POST'])
app.add_url_rule('/get_all_delivery', view_func=Manager.Get_All_Delivery, methods = ['POST'])
app.add_url_rule('/get_all_delivery', view_func=Manager.Get_All_Delivery, methods = ['POST'])
app.add_url_rule('/acctept_request', view_func=Manager.Accept_Request, methods = ['POST'])
app.add_url_rule('/reject_request', view_func=Manager.Reject_Request, methods = ['POST'])
#-----------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------

# Delivery
app.add_url_rule('/delivery_signup', view_func=Delivery.Delivery_insertion,methods=['POST'])
app.add_url_rule('/delivery_email_validation',view_func=Delivery.Delivery_email_validation,methods=['POST'])
app.add_url_rule('/delivery_phone_validation',view_func=Delivery.Delivery_PhoneNumber_validator,methods=['POST'])
app.add_url_rule('/delivery_creditcard_validation',view_func=Delivery.Delivery_CreditCard_validation,methods=['POST'])
app.add_url_rule('/delivery_license_validation',view_func=Delivery.Delivery_VehicleLicense_validator,methods=['POST'])
app.add_url_rule('/delivery_getavailableorder', view_func=Delivery.OrdersToBeDelivered, methods=['POST'])
app.add_url_rule('/delivery_getordersproducts', view_func=Delivery.ProductsofOrder, methods=['POST'])
app.add_url_rule('/delivery_assignorder', view_func=Delivery.DeliverOrder, methods=['POST'])
app.add_url_rule('/delivery_UpdateData', view_func=Delivery.UpdateData, methods=['POST'])
app.add_url_rule('/delivery_ChangePassword', view_func=Delivery.UpdatePassword, methods=['POST'])
app.add_url_rule('/delivery_totaldeliverdorders', view_func=Delivery.TotalDeliveredOrders, methods=['POST'])
app.add_url_rule('/delivery_getmydeliveredorders', view_func=Delivery.DeliveredOrders, methods=['POST'])
app.add_url_rule('/delivery_getdeliverystatus', view_func=Delivery.DeliveryStatus, methods=['POST'])
#app.add_url_rule('/delivery_Profile', view_func=Delivery.DeliveryProfile, methods=['POST'])

#-----------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------
#For Store
app.add_url_rule('/Store_signup', view_func=Store.Store_insertion,methods=['POST'])
app.add_url_rule('/Store_email_validation',view_func=Store.Store_email_validation,methods=['POST'])
app.add_url_rule('/Store_phone_validation',view_func=Store.Store_phone_validation,methods=['POST'])
app.add_url_rule('/Store2_signup', view_func=Store2.Store2_insertion,methods=['POST'])
#app.add_url_rule('/Store_getavailableInformations', view_func=Store.Store_Information, methods=['POST'])
#app.add_url_rule('/Store_UpdateInformations', view_func=Store.Update_Store_table, methods=['POST'])

#-----------------------------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------------------------
#For Product
app.add_url_rule('/Product_ADD', view_func=Add_Item.Product_Insertion ,methods=['POST'])
app.add_url_rule('/Product_Update',view_func=Add_Item.Update_Item_table ,methods=['POST'])
app.add_url_rule('/Product_getavailableProducts', view_func=Add_Item.Avaliable_Products , methods=['GET','POST'])



# For Dentist Products:
app.add_url_rule('/FetchProducts', view_func=DentistProduct.FetchProducts ,methods=['POST'])
app.add_url_rule('/NoProducts', view_func=DentistProduct.NoProducts ,methods=['POST'])

# Comments:
app.add_url_rule('/AddComment', view_func=DentistComments.AddComment ,methods=['POST'])
app.add_url_rule('/LikeComment', view_func=DentistComments.LikeComment ,methods=['POST'])
app.add_url_rule('/ViewComments', view_func=DentistComments.ViewComments ,methods=['POST'])
app.add_url_rule('/NoComments', view_func=DentistComments.NoComments ,methods=['POST'])
app.add_url_rule('/ViewLikes', view_func=DentistComments.ViewLikes ,methods=['POST'])



# ------------------------------------------------------------------------------------------------------------
# For Cart:
app.add_url_rule('/ClearCart', view_func=Cart.ClearCart ,methods=['POST'])
app.add_url_rule('/ShipCart', view_func=Cart.ShipCart ,methods=['POST'])
app.add_url_rule('/ViewCart', view_func=Cart.ViewCart ,methods=['POST'])
app.add_url_rule('/AddtoCart', view_func=Cart.AddtoCart ,methods=['POST'])
app.add_url_rule('/RemoveFromCart', view_func=Cart.RemoveFromCart ,methods=['POST'])
app.add_url_rule('/ShipCart', view_func=Cart.ShipCart ,methods=['POST'])
app.add_url_rule('/GetTotalPrice', view_func=Cart.GetTotalPrice ,methods=['POST'])

def run_server(debug=False):
    app.run(debug=debug)

if __name__ == "__main__":
    run_server(debug=False)





