import 'package:flutter/material.dart';

onFail(scaffoldKey, String msg) {
  return scaffoldKey.currentState.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ),
  );
}