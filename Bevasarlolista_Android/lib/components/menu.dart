import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home.dart';
import '../pages/lists.dart';
import '../pages/profil.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Bevásárlólista',
                  style: TextStyle(
                    //color: Colors.green.withAlpha(160),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.green,
                  ),
                ),
              ],
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('img/trolley.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.green,
            ),
            title: const Text('Főoldal'),
            onTap: () {
              Get.toNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.all_inbox,
              color: Colors.green,
            ),
            title: const Text('Listáim'),
            onTap: () {
              Get.toNamed('/lists');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: const Text('Profil'),
            onTap: () {
              Get.toNamed('/profil');
            },
          ),
        ],
      ),
    );
  }
}
