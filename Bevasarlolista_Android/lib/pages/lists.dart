import 'package:bevasarlolista_android/controller/listaController.dart';
import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../components/menu.dart';

TextEditingController ujListaNeve = TextEditingController();


class EditListButton extends StatelessWidget {
  final _controller = Get.put(ListaController());

  EditListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Szerkesztés",
              content: const TextField(),
              confirm:
                  ElevatedButton(onPressed: () {}, child: const Text("Ok")));
        },
        icon: const Icon(Icons.edit));
  }
}

class DeleteListButton extends StatefulWidget {
  int? id;
  bool? subject;
  DeleteListButton({Key? key, this.id, this.subject}) : super(key: key);

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
              confirm: ElevatedButton(
                onPressed: () async {
                  print(widget.id);
                  try{
                    await Dio().delete('http://10.0.2.2:8881/api/listak/${widget.id}');
                  }catch(e){
                    print("Hiba: ${e}");
                  }
                  /*if(widget.subject!){
                    //ToDo: lista törlése
                    print("lista törlés");
                  }else{
                    //ToDo: elem törlése
                    print("elem törlése");
                  }*/
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                child: const Text("Ok"),
              ),
              cancel: ElevatedButton(
                onPressed: () {

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
            future: ListaController().loadListNames(),
            builder: (context, list){
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
              } else{
                return GetBuilder<ListaController>(
                  init: ListaController(),
                  builder: (listaController) {
                    return ListView.builder(
                        itemCount: listaController.lista.length,
                        itemBuilder: (context, index) {
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                const ShareListButton(),
                                DeleteListButton(id: listaController.lista[index].id),
                                EditListButton(),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                listaController.lista[index].nev!,
                                textAlign: TextAlign.left,
                              ),
                              onTap: () {
                                Get.toNamed('/viewlist/${listaController.lista[index].id}');
                              },
                              tileColor: Colors.green[400],
                            ),
                          );
                        }

                    );
                    //}
                  },
                );
              }
            },
          ),
        ));
  }
}

class CreateNewListButton extends StatefulWidget {
  const CreateNewListButton({
    Key? key
  }) : super(key: key);

  @override
  State<CreateNewListButton> createState() => _CreateNewListButtonState();
}

class _CreateNewListButtonState extends State<CreateNewListButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          print("text: ${ujListaNeve.text}");
          ListaModel content = ListaModel(userid: 1, nev: ujListaNeve.text);
          var response = await Dio().post('http://10.0.2.2:8881/api/listak', data: content.toJson(),);
          print(response);
          Navigator.of(context).pop();
          setState(() {
            _ListsState();
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
