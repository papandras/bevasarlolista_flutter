import 'package:bevasarlolista_android/controller/userController.dart';
import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:bevasarlolista_android/pages/lists.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateNewListButton extends StatefulWidget {
  const CreateNewListButton({Key? key}) : super(key: key);

  @override
  State<CreateNewListButton> createState() => _CreateNewListButtonState();
}

class _CreateNewListButtonState extends State<CreateNewListButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          print("text: ${ujListaNeve.text}");
          print('${UrlPrefix.prefix}/api/listak');
          ListaModel content = ListaModel(userid: UserController.loggeduser!.id!, nev: ujListaNeve.text);
          var response = await Dio().post(
            '${UrlPrefix.prefix}/api/listak',
            data: content.toJson(),
          );
          print(response);
          Navigator.of(context).pop();
          setState(() {
            //_ListsState();
          });
        } catch (e) {
          //print("hiba: $e");
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      child: const Text("Mentés"),
    );
  }
}
