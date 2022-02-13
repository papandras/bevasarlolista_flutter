import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home.dart';
import 'pages/lists.dart';
import 'pages/login.dart';
import 'pages/profil.dart';

void main() {
  runApp(GetMaterialApp(home: const Login(), getPages: [
    GetPage(name: '/', page: ()=>const Home()),
    GetPage(name: '/login', page: ()=>const Login()),
    GetPage(name: '/register', page: (){return const Scaffold();}),
    GetPage(name: '/lists', page: ()=>const Lists()),
    GetPage(name: '/lists/:list', page: ()=>const Lists()),
    GetPage(name: '/profil', page: ()=>const Profil()),
  ],));
}

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginPage();
}