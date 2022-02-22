import 'package:bevasarlolista_android/controller/listaController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/home.dart';
import 'pages/lists.dart';
import 'pages/login.dart';
import 'pages/profil.dart';
import 'pages/register.dart';
import 'pages/viewlist.dart';

ListaController listaController = Get.find<ListaController>();

void main() {
  runApp(GetMaterialApp(
    home: const Login(),
    getPages: [
      GetPage(name: '/', page: () => const Home()),
      GetPage(name: '/login', page: () => const Login()),
      GetPage(name: '/register', page: () => const Register()),
      GetPage(name: '/lists', page: () => const Lists()),
      GetPage(name: '/lists/:list', page: () => const Lists()),
      GetPage(name: '/profil', page: () => const Profil()),
      GetPage(name: '/viewlist', page: () => const ViewListContent()),
    ],
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginPage();
}

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => RegisterPage();
}
