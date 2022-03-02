import 'package:bevasarlolista_android/model/lista_elem_model.dart';
import 'package:bevasarlolista_android/pages/viewlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';



class EditListButton extends StatelessWidget {
  TextEditingController _listaElemUjNeve = new TextEditingController();
  int? id;
  dynamic editFunction;
  String? name;
  EditListButton({
    Key? key, this.id, this.name, this.editFunction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Szerkesztés",
              content: TextField(
                controller: _listaElemUjNeve,
              ),
              confirm:
              ElevatedButton(onPressed: () async {
                await editFunction(id, _listaElemUjNeve.text);
                Navigator.of(context).pop();
              }, child: const Text("Ok")));
        },
        icon: const Icon(Icons.edit));
  }
}