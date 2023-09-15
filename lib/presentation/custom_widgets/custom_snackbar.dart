import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

void customSnackBar(String? message, BuildContext context,
    {bool isError = true, bool isToaster = false}) {
  if (isToaster) {
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      content: Text(message!),
    ));
  }
}
