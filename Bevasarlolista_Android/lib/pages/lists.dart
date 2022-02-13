import 'dart:convert';

import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../components/menu.dart';

TextEditingController UjListaController = TextEditingController();

Future<List<String>> loadListNames() async {
  List<String> listaNevek = [];
  var response = await Dio().get('http://10.0.2.2:8881/api/listak');
  try {
    for( int i = 0 ; i < response.data["data"].length; i++ ) {
      listaNevek.add(response.data["data"][i]["nev"].toString());
    }
  } catch (e) {
    print("Hiba:  $e");
  }
  return listaNevek;
}

List<dynamic> kirajzol(adatok){
  return adatok.map((nev) {
    return Slidable(
      startActionPane: const ActionPane(
        motion: ScrollMotion(), children: [
          ShareListButton(),
          DeleteListButton(),
          EditListButton(),
      ],
      ),
      child: ListTile(title: Text(
          nev,
        textAlign: TextAlign.center,
      ),
        onTap: (){},
        tileColor: Colors.green[400],
      ),
    );
  }).toList();
}

class EditListButton extends StatelessWidget {
  const EditListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Get.defaultDialog(title: "Szerkesztés", content: const TextField(), confirm: ElevatedButton(
          onPressed: (){

          }, child: const Text("Ok")));
    }, icon: const Icon(Icons.edit));
  }
}

class DeleteListButton extends StatelessWidget {
  const DeleteListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Get.defaultDialog(title: "Biztosan törli?", confirm: ElevatedButton(
          onPressed: (){

          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
          ), child: const Text("Ok"),),
        cancel: ElevatedButton(onPressed: (){},
            child: const Text("Mégse"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
          ),
        )
      );
    },  icon: const Icon(Icons.delete));
  }
}

class ShareListButton extends StatelessWidget {
  const ShareListButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      Get.defaultDialog(title: "Kivel?", content: const TextField(), confirm: ElevatedButton(
          onPressed: (){

          }, child: const Text("Ok")));
    }, icon: const Icon(Icons.share));
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
        onPressed: (){
          Get.defaultDialog(title: "Új lista létrehozása",
          content: TextField(
            controller: UjListaController,
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
        onRefresh: ()async{
          setState(() {
            _ListsState();
          });
        },
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: loadListNames(),
            builder: (context, list){
              if(list.connectionState != ConnectionState.done){
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
                        child: Text("Töltünk",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.yellow,
                          letterSpacing: 2.0,
                          fontSize: 20.0
                        ),),
                      ),
                    ],),
                  ),
                );
              }else{
                return Column(
                  children: [
                    ...kirajzol(list.data),
                  ],
                );
              }
            },
          ),
        ),
      )
    );
  }
}

class CreateNewListButton extends StatefulWidget {
  const CreateNewListButton({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateNewListButton> createState() => _CreateNewListButtonState();
}

class _CreateNewListButtonState extends State<CreateNewListButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: ()async{
      try{
        ListaModel content = ListaModel(userid: 1, nev: UjListaController.text);
        var response = await Dio().post(
            'http://10.0.2.2:8881/api/listak',
            data: content.toJson(),
        );
        setState(() {
          _ListsState();
        });
      }
      catch(e){
        print("hiba: $e");
      }

    },style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
    ), child: const Text("Mentés"),
    );
  }
}