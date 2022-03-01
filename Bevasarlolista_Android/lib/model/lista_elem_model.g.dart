// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_elem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListaElemModel _$ListaELemModelFromJson(Map<String, dynamic> json) =>
    ListaElemModel(
      id: json['id'] as int?,
      lista_id: json['lista_id'] as int?,
      content: json['nev'] as String?,
    );

Map<String, dynamic> _$ListaELemModelToJson(ListaElemModel instance) =>
    <String, dynamic>{
      'lista_id': instance.lista_id,
      'id': instance.id,
      'name': instance.content,
    };
