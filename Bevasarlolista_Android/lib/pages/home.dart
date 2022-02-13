import 'package:flutter/material.dart';
import '../components/menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: const Text(
          'Bevásárlólista',
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: const Menu(),
    );
  }
}
