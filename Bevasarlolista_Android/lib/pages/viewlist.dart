import 'package:bevasarlolista_android/components/menu.dart';
import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'lists.dart';

Future<List<String>> loadListItems() async {
  List<String> listaElemek = [];
  var response = await Dio().get('http://10.0.2.2:8881/api/listak/6/elemek');
  try {
    for (int i = 0; i < response.data["data"].length; i++) {
      listaElemek.add(response.data["data"][i]["nev"].toString());
    }
  } catch (e) {
    print("Hiba:  $e");
  }
  return listaElemek;
}

List<dynamic> kirajzol(adatok) {
  return adatok.map((listanev) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          DeleteListButton(id: 0),
          EditListButton(),
        ],
      ),
      child: ListTile(
        title: Text(
          listanev,
          textAlign: TextAlign.left,
        ),
        onTap: () {},
        tileColor: Colors.green[400],
      ),
    );
  }).toList();
}

class ViewListContent extends StatefulWidget {
  const ViewListContent({Key? key}) : super(key: key);

  @override
  _ViewListContentState createState() => _ViewListContentState();
}

class _ViewListContentState extends State<ViewListContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[200],
        appBar: AppBar(
          title: const Text(
            'Megnyitott lista elemei',
          ),
          backgroundColor: Colors.green,
          centerTitle: true,
          elevation: 0.0,
        ),
        drawer: const Menu(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[800],
          onPressed: () {
            Get.defaultDialog(
              title: "Új elem hozzáadása",
              content: TextField(
                controller: ujListaNeve,
              ),
              confirm: const CreateNewListItemButton(),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          backgroundColor: Colors.white,
          strokeWidth: 5.0,
          displacement: 100,
          edgeOffset: 30,
          color: Colors.green,
          onRefresh: () async {
            setState(() {
              _ViewListContentState();
            });
          },
          child: FutureBuilder(
            future: loadListItems(),
            builder: (context, list) {
              if (list.connectionState != ConnectionState.done) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(
                          color: Colors.yellow,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Töltünk",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.yellow,
                                letterSpacing: 2.0,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: kirajzol(list.data).length,
                  itemBuilder: (context, index) {
                    return kirajzol(list.data)[index];
                  },
                );
              }
            },
          ),
        ));
  }
}

class CreateNewListItemButton extends StatefulWidget {
  const CreateNewListItemButton({
    Key? key
  }) : super(key: key);

  @override
  State<CreateNewListItemButton> createState() => _CreateNewListItemButtonState();
}

class _CreateNewListItemButtonState extends State<CreateNewListItemButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          print("text: ${ujListaNeve.text}");
          ListaModel content = ListaModel(userid: 1, nev: ujListaNeve.text);
          var response = await Dio().post('http://10.0.2.2:8881/api/listak/6/elemek/ujelem', data: content.toJson(),);
          print(response);
          setState(() {
            _ViewListContentState();
          });
        } catch (e) {
          //print("hiba: $e");
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      child: const Text("Mentés"),
    );
  }
}
