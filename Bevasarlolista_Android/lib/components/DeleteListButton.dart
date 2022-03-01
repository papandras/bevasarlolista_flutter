import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class DeleteListButton extends StatefulWidget {
  int? id;
  //0 = lista, 1 = elem
  bool? subject;
  dynamic deleteFunction;

  DeleteListButton({Key? key, this.id, this.subject, this.deleteFunction}) : super(key: key);

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
              middleText: "",
              confirm: ElevatedButton(
                onPressed: () async {
                  widget.deleteFunction(widget.id);
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red)),
                child: const Text("Ok"),
              ),
              cancel: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Mégse"),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
              ));
        },
        icon: const Icon(Icons.delete));
  }
}