import 'package:flutter/material.dart';
import 'package:dentista/Screens_Handler/mainscreen.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dentista/Models/AuthButtons.dart';
import 'package:dentista/Models/AuthenticationFields.dart';
import 'package:dentista/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dentista/Auth/Validations.dart';
import 'package:dentista/Models/Alerts.dart';
import'package:dentista/Store Screens/Store_Home.dart';
class AddItem extends StatefulWidget {
  final String Store_name;
  final String ID;
  final String email;
  AddItem(this.Store_name, this.email, this.ID);
  @override
  _AddItemState createState() => _AddItemState(Store_name, email, ID);
}


class _AddItemState extends State<AddItem> {
  String email;
  String Store_name = "";
  String ID = "";
  _AddItemState(this.Store_name, this.email, this.ID);
  final _formKey = GlobalKey<FormState>();  // Used to validating the form
  String Product_Name="";
  String No_Of_Units="";
  String Price="";
  String Sell_Price="";

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Item",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
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
                padding: EdgeInsets.only(left: 30, right: 30, top: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: authDecoration("Product Name"),
                          onChanged: (val){
                            setState(() {
                              Product_Name = val;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: authDecoration("Number of Units"),
                          onChanged: (val) {
                            setState(() {
                              No_Of_Units = val;
                            });
                          },
                          validator: (val){
                            return val.isEmpty ? "Enter a valid number" : null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: authDecoration("Actual Price"),
                          onChanged: (val){
                            setState(() {
                              Price = val;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          decoration: authDecoration("Selling Price"),
                          onChanged: (val) {
                            setState(() {
                              Sell_Price = val;
                            });
                          },
                          validator: (val){
                            return val.isEmpty ? "Enter a valid number" : null;
                          },
                        ),
                        SizedBox(height: 20),
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
                      onTap:  () async{
                        {

                            // Sending to Database
                            final response = await http.post(
                              'http://10.0.2.2:5000/Product_ADD',
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: json.encode({

                                'NUMBER_OF_UNITS': No_Of_Units,
                                'STORE_ID': ID,
                                'PRODUCT_ID': Product_Name,
                              }),
                            );
                            Alert(context, "Item Added successfully", "Press ok to continue", message2: "");
                          }

                      },
                      child: drawButton("Add Item", Colors.green),
                    ),
                  ),
                  SizedBox(width: 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context)=>StoreHome(Store_name, email, ID) ));
                      },
                      child: drawButton("Back to Home", Colors.green),
                    ),
                  ),

                ],
              ),
            )

          ],
        )
    );
  }
}