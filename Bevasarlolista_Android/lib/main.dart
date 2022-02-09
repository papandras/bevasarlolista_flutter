import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const MaterialApp(home: Login()));
}

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginPage();
}