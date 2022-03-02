import 'dart:convert';

import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:get/get.dart';
import '../main.dart';

TextEditingController fullname = TextEditingController();
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController password_confirm = TextEditingController();
TextEditingController email = TextEditingController();


class RegisterPage extends State<Register> {
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
              children: const <Widget>[
                RegisterTitle(),
                Divider(
                  height: 40.0,
                  color: Colors.white,
                ),
                FullName(),
                UserName(),
                Password(),
                PasswordConfirm(),
                Email(),
                Divider(
                  height: 40.0,
                ),
                RegisterButton(),
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

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if(password.text != password_confirm.text){
          password_confirm.text == null;
          _showDialog(context, 'A jelszavak nem egyeznek!');
        }
        else if(password.text == '' || password_confirm.text == '' || username.text == '' || email.text == ''){
          _showDialog(context, 'Tölts ki minden mezőt!');
        }
        else{
          var kepfeltolt = await Dio().post('https://kek.sh/api/v1/posts', data: {"url": Gravatar(email.text).imageUrl()}, options: Options(headers: {
            'x-kek-auth': 'Tz5tAbLmsKVfBrLp.5qcQc57wnNUHoFeTD,h6DrfOCFIaqV9A4qJq'
          }));
          dynamic userdata = {
            'fullname': fullname.text,
            'name': username.text,
            'password': password.text,
            'email': email.text,
            'profilpicture': 'https://i.kek.sh/${kepfeltolt.data["filename"]}',
          };
          try{
            var response = await Dio().post('${UrlPrefix.prefix}/api/regisztracio', data: jsonEncode(userdata));
            print(response);
            Get.toNamed('/login');
          }catch(e){
            print("Hiba: ${e}");
            _showDialog(context, e.toString());
          }
        }
        //Get.toNamed('/login');
      },
      child: const Text(
        'Regisztrálok',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.green[400],
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
    );
  }
}

class Email extends StatelessWidget {
  const Email({
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
            'Email cím:',
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
          controller: email,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.alternate_email_outlined),
          ),
        ),
      ],
    );
  }
}

class PasswordConfirm extends StatelessWidget {
  const PasswordConfirm({
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
            'Jelszó megerősítése:',
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
          controller: password_confirm,
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

class FullName extends StatelessWidget {
  const FullName({
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
            'Teljes név:',
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
          controller: fullname,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.person),
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
          padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
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

class RegisterTitle extends StatelessWidget {
  const RegisterTitle({
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
              "Regisztráció",
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
