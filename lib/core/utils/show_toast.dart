import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    fontSize: 16,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: Colors.black87,
    textColor: Colors.white,
  );
}
