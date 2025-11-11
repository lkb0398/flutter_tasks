// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => _TodoModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  isFavorite: json['is_favorite'] as bool,
  isDone: json['is_done'] as bool,
);

Map<String, dynamic> _$TodoModelToJson(_TodoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'is_favorite': instance.isFavorite,
      'is_done': instance.isDone,
    };
