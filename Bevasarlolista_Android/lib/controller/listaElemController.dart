import 'package:bevasarlolista_android/model/lista_elem_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ListeElemController extends GetxController{
  dynamic _listaElemek = Rx<List<ListaELemModel>>([]);
  List<ListaELemModel> get listaElemek => _listaElemek.value;
  static String? ListaId;

  Future<void> loadListItems() async {
    print('http://10.0.2.2:8881/api/listak/${ListaId}');
    var response = await Dio().get('http://10.0.2.2:8881/api/listak/${ListaId}');
    try {
      for (int i = 0; i < response.data["data"].length; i++) {
        _listaElemek.value.add(ListaELemModel.fromJson(response.data["data"][i]));
      }
      print(response);
    } catch (e) {
      print("Hiba:  $e");
    }
    print(listaElemek.length);
  }

  @override
  void onInit(){
    loadListItems();
  }
}