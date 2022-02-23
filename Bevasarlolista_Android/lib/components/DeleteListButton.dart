import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DeleteListButton extends StatefulWidget {
  int? id;
  //0 = lista, 1 = elem
  bool? subject;

  DeleteListButton({Key? key, this.id, this.subject}) : super(key: key);

  @override
  State<DeleteListButton> createState() => _DeleteListButtonState();
}

class _DeleteListButtonState extends State<DeleteListButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Biztosan törli?",
              confirm: ElevatedButton(
                onPressed: () async {
                  print(widget.id);

                  if(widget.subject!){
                    try {
                      await Dio()
                          .delete('http://10.0.2.2:8881/api/listak/${widget.id}');
                    } catch (e) {
                      print("Hiba: ${e}");
                    }
                    print("lista törlés");
                  }else{
                    //ToDo: elem törlése
                    print("elem törlése");
                  }
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: const Text("Ok"),
              ),
              cancel: ElevatedButton(
                onPressed: () {},
                child: const Text("Mégse"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
              ));
        },
        icon: const Icon(Icons.delete));
  }
}