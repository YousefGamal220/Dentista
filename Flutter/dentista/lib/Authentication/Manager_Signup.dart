import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManagerSignup extends StatefulWidget {
  @override
  _ManagerSignupState createState() => _ManagerSignupState();
}

class _ManagerSignupState extends State<ManagerSignup> {
  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  //Variables to be sent to the backend 
  String firstName ='';
  String lastName ='';
  String email ='';
  String password ='';
  String repassword ='';
  String manageType ='';
  ////////////////////////////////////
  List<String> managementType = ["Store Management" , "Delivery Management"];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //We used safearea widget to avoid rendering under notification bar
          SafeArea(
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"
                    ),
                  ),
                  Row(
                    children: [
                      Text("Manager" ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60.0,
                        ),
                      ),
                      Text("." ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 90.0,
                            color: Colors.green
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 30,right: 30 , top: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: authDecoration("First Name"),
                        onChanged: (val){
                          setState(() {
                            firstName = val;
                          });
                        },
                        validator: (val)
                        {
                           return val.isEmpty ? "Please Enter Your FirstName" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          decoration: authDecoration("Last Name"),
                        onChanged: (val){
                          setState(() {
                            lastName = val;
                          });
                        },
                        validator: (val)
                        {
                          return val.isEmpty ? "Please Enter Your LastName" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: authDecoration("Email"),
                        onChanged: (val){
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val)
                        {
                          return val.isEmpty ? "Please Enter Your Email" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: authDecoration("Password"),
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                        validator: (val)
                        {
                          return val.length<6 ? "Password must be more than 6 characters" : null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: authDecoration("Re-Enter Password"),
                        onChanged: (val){
                          setState(() {
                            repassword = val;
                          });
                        },
                        validator: (val)
                        {
                          return val != password ? "The Password doesn't match" : null;
                        },
                      ),

                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField(
                              decoration: authDecoration("Management Type"),
                              items: managementType.map((typ){
                                return DropdownMenuItem(
                                  value: typ,
                                  child: Text(typ),
                                );
                              }).toList(),
                              onChanged: (val){
                                manageType = val;
                              },
                              validator: (val)
                              {
                                return val==null ? "Please Choose Type" : null;
                              },
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: authDecoration("Area"),
                              onChanged: (val){
                                setState(() {
                                  repassword = val;
                                });
                              },
                              validator: (val)
                              {
                                return val.isEmpty ? "Enter Area" : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      //if condition to check if the all inputs are valid
                      if(_formKey.currentState.validate())
                        {
                          //For Testing only
                          //backend code should be written here
                          
                          print("Done");
                        }
                    },
                    child: drawButton("Register", Colors.green),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: GestureDetector(
                    onTap: (){},
                    child: drawButton("Back to sign in", Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}