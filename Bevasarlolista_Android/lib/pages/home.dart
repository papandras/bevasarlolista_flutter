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
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    color: Colors.green[800],
                    child: const Center(
                        child: Text(
                            'A bevásárlólista alkalmazás üdvözöl!',
                            style: TextStyle(
                              fontSize: 20.0
                            ),
                        )
                    ),
                  ),
                  Container(
                    height: 50,
                    color: Colors.green[700],
                    child: const Center(child: Text('Ez egy hasznos kis app, ahol tudsz: ')),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
