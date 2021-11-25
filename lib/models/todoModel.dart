import 'package:json_annotation/json_annotation.dart';
part 'todoModel.g.dart';

@JsonSerializable()
class TodoDetails {
  int? importance;
  bool? isCompleted;
  String? title;
  String? tid;

  TodoDetails({this.importance, this.isCompleted, this.title, this.tid});

  factory TodoDetails.fromJson(Map<String, dynamic> data) => _$TodoDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$TodoDetailsToJson(this);
}
