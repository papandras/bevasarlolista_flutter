import 'package:bevasarlolista_android/components/DeleteListButton.dart';
import 'package:bevasarlolista_android/components/EditListButton.dart';
import 'package:bevasarlolista_android/components/ShareListButton.dart';
import 'package:bevasarlolista_android/components/menu.dart';
import 'package:bevasarlolista_android/controller/listaElemController.dart';
import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'lists.dart';

class ViewListContent extends StatefulWidget {
  const ViewListContent({Key? key}) : super(key: key);

  @override
  _ViewListContentState createState() => _ViewListContentState();
}

class _ViewListContentState extends State<ViewListContent> {
  final ListaElemController listaElemController = Get.put(ListaElemController());

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    ListaElemController.ListaId = args.toString();
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
              confirm: CreateNewListItemButton(id: args.toString()),
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
            future: listaElemController.loadListItems(),
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
              } else if(listaElemController.listaElemek.length == 0){
                return ListView(children: const [
                Center(child: Text("A lista nem tartalmaz elemeket"))
                ]);
              }else {
                return Obx(() => ListView.builder(
                    itemCount: listaElemController.listaElemek.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            const ShareListButton(),
                            DeleteListButton(
                              id: listaElemController.listaElemek[index].id, subject: false, deleteFunction: listaElemController.Delete,),
                            EditListButton( id: listaElemController.listaElemek[index].id, name: listaElemController.listaElemek[index].content, editFunction: listaElemController.Edit),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            listaElemController.listaElemek[index].content!,
                            textAlign: TextAlign.left,
                          ),
                          onTap: () {
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

class CreateNewListItemButton extends StatefulWidget {
  final String? id;
  const CreateNewListItemButton({
    Key? key, this.id
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
          ListaModel content = ListaModel(nev: ujListaNeve.text);
          var response = await Dio().post('${UrlPrefix.prefix}/api/listak/${widget.id}/elemek/ujelem', data: content.toJson());
          Navigator.of(context).pop();
          print(response);
          setState(() {
            _ViewListContentState();
          });
        } catch (e) {
          print("hiba: $e");
        }
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
      child: const Text("Mentés"),
    );
  }
}
