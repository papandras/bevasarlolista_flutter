import 'dart:convert';

import 'package:bevasarlolista_android/components/menu.dart';
import 'package:bevasarlolista_android/controller/userController.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

TextEditingController password = new TextEditingController();
TextEditingController fullname = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController profilpicture = new TextEditingController();

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          'Bevásárlólista',
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: const Menu(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Title(),
                const Divider(
                  height: 40.0,
                  color: Colors.white,
                ),
                const FullName(),
                const Email(),
                const ProfilPicture(),
                const Password(),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  child: const SaveButton(),
                ),
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

class Title extends StatelessWidget {
  const Title({
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
              "Beállítások",
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.person),
            hintText: "${UserController.loggeduser!.fullname!}"
          ),
        ),
      ],
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.alternate_email_outlined),
              hintText: "${UserController.loggeduser!.email!}"
          ),
        ),
      ],
    );
  }
}

class ProfilPicture extends StatelessWidget {
  const ProfilPicture({
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
            'Profil kép:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1.5,
            ),
          ),
        ),
        TextField(
          maxLength: 100,
          controller: profilpicture,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.image)),
            hintText: "${UserController.loggeduser!.profilpicture!}"
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if(fullname.text == ""){
          fullname.text = UserController.loggeduser!.fullname!;
        }
        if(email.text.isEmpty == true){
          email.text = UserController.loggeduser!.email!;
        }
        if(profilpicture.text == ""){
          profilpicture.text = UserController.loggeduser!.profilpicture!;
        }
        if(password.text != ""){
          var kepfeltolt = await Dio().post('https://kek.sh/api/v1/posts', data: {"url": profilpicture.text}, options: Options(headers: {
            'x-kek-auth': 'Tz5tAbLmsKVfBrLp.5qcQc57wnNUHoFeTD,h6DrfOCFIaqV9A4qJq'
          }));
          dynamic edituserdata = {
            'fullname': fullname.text,
            'password': password.text,
            'email': email.text,
            'profilpicture': 'https://i.kek.sh/${kepfeltolt.data["filename"]}',
          };
          print(edituserdata);
          try{
            var response = await Dio().put('${UrlPrefix.prefix}/api/felhasznalo/${UserController.loggeduser!.id!}', data: jsonEncode(edituserdata));
            //_showDialog(context, "Adatok sikeresen módosítva, kérlek jelentkezz be újra!");
            Get.toNamed('/login');
          }
          catch(e){
            _showDialog(context, e.toString());
          }
        }
        else{
          _showDialog(context, "A jelszót kötelező kitölteni!");
        }

      },
      child: const Text(
        'Mentés',
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