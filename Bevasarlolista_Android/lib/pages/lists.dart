import 'package:bevasarlolista_android/components/CreateNewListButton.dart';
import 'package:bevasarlolista_android/components/DeleteListButton.dart';
import 'package:bevasarlolista_android/components/EditListButton.dart';
import 'package:bevasarlolista_android/components/ShareListButton.dart';
import 'package:bevasarlolista_android/controller/listaController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../components/menu.dart';

TextEditingController ujListaNeve = TextEditingController();

class Lists extends StatefulWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  final ListaController listaController = Get.put(ListaController());

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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green[800],
          onPressed: () {
            Get.defaultDialog(
              title: "Új lista létrehozása",
              content: TextField(
                controller: ujListaNeve,
              ),
              confirm: const CreateNewListButton(),
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
              _ListsState();
            });
          },
          child: FutureBuilder(
            future: listaController.loadListNames(),
            builder: (context, list) {
              if (list.connectionState != ConnectionState.done && listaController.lista.length == 0) {
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
                print("listaController: ${listaController.lista.length}");
                return Obx(() => ListView.builder(
                    itemCount: listaController.lista.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            const ShareListButton(),
                            DeleteListButton(
                                id: listaController.lista[index].id, subject: true, deleteFunction: listaController.Delete),
                            EditListButton(id: listaController.lista[index].id, name: ujListaNeve.text, editFunction: listaController.Edit),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            listaController.lista[index].nev!,
                            textAlign: TextAlign.left,
                          ),
                          onTap: () {
                            //Get.toNamed('/viewlist/${listaController.lista[index].id}');
                            Navigator.pushNamed(
                                context,
                                '/viewlist',
                                arguments: listaController.lista[index].id,
                            );
                          },
                          tileColor: Colors.green[400],
                        ),
                      );
                    }));
              }
            },
          ),
        ));
  }
}

