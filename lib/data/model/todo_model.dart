import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
abstract class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String title,
    required String? description,
    @JsonKey(name: "is_favorite") required bool isFavorite,
    @JsonKey(name: "is_done") required bool isDone,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
}
