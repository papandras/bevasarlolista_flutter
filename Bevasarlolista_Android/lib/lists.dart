import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

List<String> listaNevek = [];
List<String >valami = ["egy", "ketto"];
void loadListNames() async{
  var response = await Dio().get('http://10.0.2.2:8881/api/listak');
  try {
    for( int i = 0 ; i < response.data["data"].length; i++ ) {
      listaNevek.add(response.data["data"][i]["nev"].toString());
    }
  } catch (e) {
    print("Hiba:  $e");
  }
}

dynamic kirajzol(adatok){
  return adatok.map((nev) {
    return Text(nev);
  }).toList();
}

class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: const Text(
          'Listáim',
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: const Menu(),
      body: Column(
        children: kirajzol(valami),
      ),
    );
  }
}