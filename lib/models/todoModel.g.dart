// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoDetails _$TodoDetailsFromJson(Map<String, dynamic> json) {
  return TodoDetails(
    importance: json['importance'] as int?,
    isCompleted: json['isCompleted'] as bool?,
    title: json['title'] as String?,
    tid: json['tid'] as String?,
  );
}

Map<String, dynamic> _$TodoDetailsToJson(TodoDetails instance) =>
    <String, dynamic>{
      'importance': instance.importance,
      'isCompleted': instance.isCompleted,
      'title': instance.title,
      'tid': instance.tid,
    };
