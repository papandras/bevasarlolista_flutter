import 'package:bevasarlolista_android/model/lista_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ListaController extends GetxController{
  dynamic _lista = Rx<List<ListaModel>>([]);
  List<ListaModel> get lista => _lista.value;

  Future<void> loadListNames() async {
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

  @override
  void onInit(){
    loadListNames();
  }
}