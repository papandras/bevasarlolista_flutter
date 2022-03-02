import 'package:bevasarlolista_android/model/lista_elem_model.dart';
import 'package:bevasarlolista_android/model/urlprefix.dart';
import 'package:bevasarlolista_android/pages/lists.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ListaElemController extends GetxController{
  dynamic _listaElemek = Rx<List<ListaElemModel>>([]);
  List<ListaElemModel> get listaElemek => _listaElemek.value;
  static String? ListaId;

  Future<void> loadListItems() async {
    _listaElemek = Rx<List<ListaElemModel>>([]);
    var response = await Dio().get('${UrlPrefix.prefix}/api/listak/${ListaId}');
    try {
      for (int i = 0; i < response.data["data"].length; i++) {
        _listaElemek.value.add(ListaElemModel.fromJson(response.data["data"][i]));
      }
      print(response);
    } catch (e) {
      print("Hiba:  $e");
    }
    print(listaElemek.length);
  }

  Future<void> Delete(int id) async {
    try {
      await Dio().delete('${UrlPrefix.prefix}/api/listak/elemek/$id', options: Options(followRedirects: false, validateStatus: (status){
        return status! < 500;
      }));
      loadListItems();
    } catch (e) {
      print("Hiba: ${e}");
    }
  }

  Future<void> Edit(int id, String name) async {
    try {
      var content = ListaElemModel(id: id, content: name);
      await Dio().put('${UrlPrefix.prefix}/api/listak/elemek/$id', options: Options(followRedirects: false, validateStatus: (status){
        return status! < 500;
      }), data: content.toJson());
      loadListItems();
    } catch (e) {
      print("Hiba: ${e}");
    }
  }

}