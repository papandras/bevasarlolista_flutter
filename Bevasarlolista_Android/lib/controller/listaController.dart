import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ListaController extends GetxController{
  dynamic _lista = Rx<List<ListaModel>>([]);
  List<ListaModel> get lista => _lista.value;

  Future<void> loadListNames() async {
    _lista = Rx<List<ListaModel>>([]);
    var response = await Dio().get('http://10.0.2.2:8881/api/listak');
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
      await Dio().delete('http://10.0.2.2:8881/api/listak/$id', options: Options(followRedirects: false, validateStatus: (status){
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
      await Dio().put('http://10.0.2.2:8881/api/listak/$id', options: Options(followRedirects: false, validateStatus: (status){
        return status! < 500;
      }), data: content.toJson());
      loadListNames();
    } catch (e) {
      print("Hiba: ${e}");
    }
  }
}