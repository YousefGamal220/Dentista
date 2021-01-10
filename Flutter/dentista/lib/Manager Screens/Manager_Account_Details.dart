import 'dart:convert';

import 'package:dentista/Authentication/AuthController.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/Models/SharedTextStyle.dart';
import 'package:dentista/UsersControllers/ManagerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http ;

class ManagerAccountDetails extends StatefulWidget {
  @override
  _ManagerAccountDetailsState createState() => _ManagerAccountDetailsState();
}

class _ManagerAccountDetailsState extends State<ManagerAccountDetails> {
  final AuthController authController = Get.put(AuthController());
  String updatedValue;
  final _formKey = GlobalKey<FormState>();
  Map SplitNameString()
  {
    String s = updatedValue;
    int idx = s.indexOf(" ");
    List names = [s.substring(0,idx).trim(), s.substring(idx+1).trim()];
   return {"MANAGER_Fname" : names[0] , "MANAGER_Lname" : names[1]};
  }
  void displayBottomSheet(BuildContext context,String hintText,String ColumnName) {
    showModalBottomSheet(
      backgroundColor: Colors.blueGrey[100],
      isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      onChanged: (val)
                      {
                        setState(() {
                          updatedValue = val;
                        });
                      },
                      autofocus: true,
                      decoration: authDecoration('Enter new '+hintText),
                      validator: (val){
                        return val.isEmpty? 'Please Enter A Value' : null;
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: RaisedButton(
                      onPressed: ()async{
                        if(_formKey.currentState.validate())
                          {
                            Map dict;
                            if(hintText == 'name') {
                              dict = SplitNameString();
                            }
                            else if(hintText == 'email')
                              {
                                authController.setEmail(updatedValue);
                              }
                            final updatedata = await http.post(
                              'http://10.0.2.2:5000/manager_update',
                              headers: <String,String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                                'Charset': 'utf-8'
                              },
                              body: json.encode({
                                "dic" :hintText=='name' ? dict :{"$ColumnName":"$updatedValue"},
                                "MID"  : managerController.Manager_ID.value
                              }),
                            );
                            managerController.onInit();
                            Navigator.pop(context);
                          }
                      },
                      color: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black87)
                      ),
                      child: Text("Update" , style: TextStyle( fontFamily: 'montserrat',
                        fontWeight: FontWeight.w600,),),
                    ),
                  ),
                ],
              ),
            )
          );
        });
  }
  final ManagerController managerController = Get.put(ManagerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Account Settings" , style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
        ),
        backgroundColor:Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 85,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("PERSONAL INFO" , style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'montserrat',
                  letterSpacing: 2.5
              ) ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 12),
                child: Container(
                  child: Obx(()=>Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person_pin),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                              Text(managerController.MFname.value+" "+managerController.MLname.value,style: requestInfoStyle()),
                            ],
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.edit), onPressed: (){
                            return displayBottomSheet(context,'name',"");
                          })
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.alternate_email),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Email " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                              Text(managerController.M_Email.value,style: requestInfoStyle()),
                            ],
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.edit), onPressed: (){
                            return displayBottomSheet(context,'email',"MANAGER_EMAIL");
                          })
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.alternate_email),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Password " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                              Text('•••••••',style: requestInfoStyle()),
                            ],
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.edit), onPressed: (){
                            return displayBottomSheet(context,'password',"MANAGER_PASSWORD");
                          })
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Manager ID " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                              Text(managerController.Manager_ID.value.toString(),style: requestInfoStyle()),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.accessibility),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Management type " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                              Text(managerController.M_Type.value,style: requestInfoStyle()),
                            ],
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.edit), onPressed: (){
                            return displayBottomSheet(context,'type','MANAGEMENT_TYPE');
                          })
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Area of management " , style: requestInfoStyle(color: Colors.blueGrey[500])),
                              Text(managerController.M_Area.value,style: requestInfoStyle()),
                            ],
                          ),
                          Spacer(),
                          IconButton(icon: Icon(Icons.edit), onPressed: (){
                            return displayBottomSheet(context,'area','AREA_OF_MANAGEMENT');
                          })
                        ],
                      ),
                      SizedBox(height: 20),

                    ],
                  ),)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
