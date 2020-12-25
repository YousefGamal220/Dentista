import 'package:dentista/Authentication/Store2_signup.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';

class StoreSignUp extends StatefulWidget {
  @override
  _StoreSignUpState createState() => _StoreSignUpState();
}

class _StoreSignUpState extends State<StoreSignUp> {
  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  Validator _validator = new Validator();   // Creating Instance of the validator
  //Variables to be sent to the backend
  String StoreName = "";
  String PhoneNumber = "";
  String CreditCardNumber = "";
  String Email = "";
  String Password = "";
  String RePassword = "";
  bool valid_email = true;

  bool policy_check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
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
                            fontFamily: "Montserrat"),
                      ),
                      Row(
                      children: [
                        Text(
                          "Store Owner",
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ".",
                          style: TextStyle(
                              fontSize: 60.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    )

                    ],
                  ),
                )),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: authDecoration("Store Name"),
                            onChanged: (val) {
                              setState(() {
                                StoreName = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty
                                  ? "Please Enter Your Store Name"
                                  : null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: authDecoration("Phone Number"),
                            onChanged: (val) {
                              setState(() {
                                PhoneNumber = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty ? "Please Enter Store Phone Number" : null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: authDecoration("Credit Card Number"),
                            onChanged: (val) {
                              setState(() {
                                CreditCardNumber = val;
                              });
                            },
                            validator: (val) {
                              if (val.isEmpty)
                                return "Please Enter Your Credit Card Number";
                              else if (val.length < 8)
                                return "Enter a Valid Credit Card Number";
                              else
                                return null;
                            },
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: authDecoration("Email"),
                            onChanged: (val) {
                              setState(() {
                                Email = val;
                              });
                            },
                            validator: (val) {
                              return val.isEmpty ? "Please Enter Your Email" : null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: authDecoration("Password"),
                            onChanged: (val) {
                              setState(() {
                                Password = val;
                              });
                            },
                            validator: (val) {
                              return val.length < 6
                                  ? "Password must be more than 6 characters"
                                  : null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: authDecoration("Re-Enter Password"),
                            onChanged: (val) {
                              setState(() {
                                RePassword = val;
                              });
                            },
                            validator: (val) {
                      if(val.length <6) return "Password must be more than 6 characters" ;

                              return val != Password
                                  ? "The Password doesn't match"
                                  : null;
                            },

                          ),
                          SizedBox(height: 20)
                        ],
                      ),
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: policy_check ? () async{

    //if condition to check if the all inputs are valid
    if(_formKey.currentState.validate())
    {

    final email_response = await http.post(
    'http://10.0.2.2:5000/Store_email_validation',
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({


    'email': Email,

    }),
    );

    final phone_response = await http.post(
    'http://10.0.2.2:5000/Store_phone_validation',
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({


    'phone': PhoneNumber,

    }),
    );

    final creditcard_validator = await http.post(
    'http://10.0.2.2:5000/Store_creditcard_validation',
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
    'CardNumber': CreditCardNumber
    }),
    );


    String ValidationEmail = email_response.body;
    String ValidationPhone = phone_response.body;
    String ValidationCreditCard = creditcard_validator.body;

    if (ValidationEmail == "0")
    {
    valid_email = false;
    //EmailAlert(context);
    Alert(context, "Invalid Email", "This Email is currently in use");
    }
    else if (ValidationPhone == "0")
    {
    Alert(context, "Invalid Phone number", "This Phone number is currently in use");
    }
    else if (ValidationCreditCard == "0")
    {
    Alert(context, "Invalid Credit Card", "This Credit Card doesn't exist", message2: "Enter a Valid One");
    }
    else
    {
    valid_email = true;
    // Sending to Database
    final response = await http.post(
    'http://10.0.2.2:5000/Store_signup',
    headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({

    'Store_Name': StoreName,
    'Store_PhoneNumber': PhoneNumber,
    'Store_EMAIL': Email,
    'Store_PASSWORD': Password,
    'Store_CREDIT_CARD_NUMBER': CreditCardNumber
    }),
    );
    Alert(context, "Signed up successfully", "Press next to continue the verification", message2: "");
    }
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context)=>Store2signup(StoreName)));

                          //   if (_formKey.currentState.validate())
                        }:null,
                        child: drawButton(
                            "Next",
                            Colors.green
                        ),
                      )
                  ),
                  SizedBox(width: 2.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context)=>Home()));
                      },
                      child: drawButton(
                          "Back to sign in",
                          Colors.grey
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
