import 'package:json_annotation/json_annotation.dart';

part 'lista_elem_model.g.dart';

@JsonSerializable()
class ListaElemModel {
  int? id;
  int? lista_id;
  String? content;

  ListaElemModel({this.id, this.lista_id, this.content});

  factory ListaElemModel.fromJson(Map<String, dynamic> json) =>
      _$ListaELemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListaELemModelToJson(this);
}
