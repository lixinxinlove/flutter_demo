import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {


  static showToast(String msg, {Color? backgroundColor, Color? textColor}) {
    Fluttertoast.showToast(
        msg: msg,
        gravity: ToastGravity.CENTER,
        backgroundColor: backgroundColor ?? const Color(0xffD8D8D8),
        textColor: textColor ?? Colors.black);
  }

}
