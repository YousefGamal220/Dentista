import 'package:flutter/material.dart';
Future<void> Alert(BuildContext context, String message_title, String message_content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message_title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message_content),
              Text('You can either try another one, or sign in'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
