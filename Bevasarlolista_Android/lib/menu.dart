import 'package:bevasarlolista_android/share.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'lists.dart';
import 'profil.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.all_inbox,
              color: Colors.green,
            ),
            title: const Text('Listáim'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Lists()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.share,
              color: Colors.green,
            ),
            title: const Text('Megosztás'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Share()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.green,
            ),
            title: const Text('Profil'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profil()),
              );
            },
          ),
        ],
      ),
    );
  }
}
