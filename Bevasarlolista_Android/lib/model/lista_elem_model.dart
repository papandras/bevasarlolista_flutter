import 'package:json_annotation/json_annotation.dart';

part 'lista_elem_model.g.dart';

@JsonSerializable()
class ListaELemModel {
  int? id;
  int? lista_id;
  String? content;

  ListaELemModel({this.id, this.lista_id, this.content});

  factory ListaELemModel.fromJson(Map<String, dynamic> json) =>
      _$ListaELemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListaELemModelToJson(this);
}
