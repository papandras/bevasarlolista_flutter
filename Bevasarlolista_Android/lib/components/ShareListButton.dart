import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ShareListButton extends StatelessWidget {
  const ShareListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Kivel?",
              content: const TextField(),
              confirm:
              ElevatedButton(onPressed: () {}, child: const Text("Ok")));
        },
        icon: const Icon(Icons.share));
  }
}