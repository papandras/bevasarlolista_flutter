// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListaModel _$ListaModelFromJson(Map<String, dynamic> json) => ListaModel(
      userid: json['userid'] as int?,
      id: json['id'] as int?,
      nev: json['nev'] as String?,
    );

Map<String, dynamic> _$ListaModelToJson(ListaModel instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'name': instance.nev,
      'id': instance.id,
    };
