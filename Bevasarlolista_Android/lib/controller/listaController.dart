import 'package:bevasarlolista_android/controller/userController.dart';
import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ListaController extends GetxController{
  dynamic _lista = Rx<List<ListaModel>>([]);
  List<ListaModel> get lista => _lista.value;

  Future<void> loadListNames() async {
    _lista = Rx<List<ListaModel>>([]);
    var response = await Dio().get('${UrlPrefix.prefix}/api/${UserController.loggeduser!.id!}/listak');
    try {
      for (int i = 0; i < response.data["data"].length; i++) {
        _lista.value.add(ListaModel.fromJson(response.data["data"][i]));
      }
      print("response: ${response}");
    } catch (e) {
      print("Hiba:  $e");
    }
  }

  Future<void> Delete(int id) async {
    try {
      await Dio().delete('${UrlPrefix.prefix}/api/listak/$id', options: Options(followRedirects: false, validateStatus: (status){
        return status! < 500;
      }));
    loadListNames();
    } catch (e) {
      print("Hiba: ${e}");
    }
  }

  Future<void> Edit(int id, String name) async {
    try {
      var content = ListaModel(userid: id, nev: name);
      await Dio().put('${UrlPrefix.prefix}/api/listak/$id', options: Options(followRedirects: false, validateStatus: (status){
        return status! < 500;
      }), data: content.toJson());
      loadListNames();
    } catch (e) {
      print("Hiba: ${e}");
    }
  }
}