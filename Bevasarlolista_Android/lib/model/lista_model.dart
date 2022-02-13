import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'lista_elem_model.dart';

part 'lista_model.g.dart';

@JsonSerializable()
class ListaModel{
  int? userid;
  String? nev;
  int? id;
  @JsonKey(ignore: true)List<ListaELem>? elemek;
  ListaModel({this.userid, this.id, this.elemek, this.nev});

  factory ListaModel.fromJson(Map<String, dynamic> json) =>
      _$ListaModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListaModelToJson(this);
}