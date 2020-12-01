import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/pages/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.red.shade900),
    home: Login(),
  ));
}
