//import 'dart:convert';

//import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'menu.dart';
//import 'menu.dart';

/*List<String> listaNevek = [];
void loadLists() async{
  var response = await Dio().get('http://10.0.2.2:8881/api/listak');
  try {
    for( int i = 0 ; i < response.data["data"].length; i++ ) {
      listaNevek.add(response.data["data"][i]["nev"].toString());
    }
  } catch (e) {
    print("Hiba:  $e");
  }
}

List<String >valami = ["egy", "ketto"];

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
        children: listaNevek.map((nev) {
          return Text(nev);
        }).toList(),
      ),
    );
  }
}*/


class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bevásárlólista',
      home: FutureBuilderExample(),
      debugShowCheckedModeBanner: false,
    );
  }
}


Future<List<String>> getValue() async {
  List<String> listaNevek = [];
  var response = await Dio().get('http://10.0.2.2:8881/api/listak');
  try {
    for( int i = 0 ; i < response.data["data"].length; i++ ) {
      listaNevek.add(response.data["data"][i]["nev"].toString());
    }
  } catch (e) {
    print("Hiba:  $e");
  }
  print("listanevek: $listaNevek");
  return listaNevek;
}

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FutureBuilderExampleState ();
  }
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  late Future<dynamic> _value;

  @override
  initState() {
    super.initState();
    _value = getValue();
    print("valuetolist: $getValue");
  }

  valueToList() async {
    await Future.delayed(Duration(seconds: 5));
    List<String> getAll() {
      List<String> nevek = [];
      _value.then((value) {
        if (value != null) {
          value.forEach((item) => nevek.add(item));
        }
      });
      print("nevek: $_value");
      return nevek == null ? [] : nevek;
    }
    return getAll();
  }

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
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: FutureBuilder<String>(
            //future: valueToList(),
            initialData: 'App Name',
            builder: (BuildContext context,
                AsyncSnapshot<String> snapshot,) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Visibility(
                      visible: snapshot.hasData,
                      child: Text(
                        snapshot.data.toString(),
                        style: const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Column(
                    children: valueToList().map((nev) {
                      return Text(nev);
                    }).toList(),
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }
}