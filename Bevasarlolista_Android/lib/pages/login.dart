import 'dart:convert';
import 'package:bevasarlolista_android/controller/userController.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:bevasarlolista_android/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import '../main.dart';

TextEditingController username = new TextEditingController();
TextEditingController password = new TextEditingController();

class LoginPage extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Bevásárlólista'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const LoginTitle(),
                const Divider(
                  height: 40.0,
                  color: Colors.white,
                ),
                const UserName(),
                const Password(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  child: const LoginButton(),
                ),
                const Divider(
                  height: 40.0,
                  color: Colors.green,
                ),
                const RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Expanded(
            child: AlertDialog(
              title: Text('Figyelmeztetés'),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Bezárás', style: TextStyle(color: Colors.black),),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

class LoginTitle extends StatelessWidget {
  const LoginTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Bejelentkezés",
              style: TextStyle(
                letterSpacing: 2.0,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed('/register');
      },
      child: const Text(
        'Regisztráció',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.green[400],
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 15),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        dynamic userdata = {
          'name': username.text,
          'password': password.text,
        };

        if(username.text != "" || password.text != ""){
          if(password.text.length > 7){
            try{
              var response = await Dio().put('${UrlPrefix.prefix}/api/bejelentkezes', data: jsonEncode(userdata));
              if(response.data["message"] == null){
                UserController.loggeduser = UserModel(
                  id: response.data["user"]["id"],
                  fullname: response.data["user"]["fullname"],
                  name: response.data["user"]["name"].toString(),
                  token: response.data["user"]["api_token"].toString(),
                  key: response.data["access_token"].toString(),
                  email: response.data["user"]["email"].toString(),
                  profilpicture:  response.data["user"]["profilpicture"].toString(),
                  created: response.data["user"]["created_at"].toString(),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }else{
                print(response.data["message"]);
                print("resp: ${response.data}");
                _showDialog(context, response.data["message"]);
              }
            }
            catch(e){
              _showDialog(context, e.toString());
            }
          }
          else{
            _showDialog(context, "A jelszó minimum 8 karakter!");
          }
        }
        else{
          _showDialog(context, "Töltsd ki az adatokat!");
        }

        /*print(UserController.loggeduser.name);
        */
      },
      child: const Text(
        'Bejelentkezés',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.green[600],
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 15),
      ),
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
          child: Text(
            'Jelszó:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
        ),
        TextField(
          maxLength: 30,
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.password),
          ),
        ),
      ],
    );
  }
}

class UserName extends StatelessWidget {
  const UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Text(
            'Felhasználó név:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
        ),
        TextField(
          maxLength: 30,
          controller: username,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ],
    );
  }
}
