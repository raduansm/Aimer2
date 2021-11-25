import 'package:json_annotation/json_annotation.dart';
part 'userModel.g.dart';

@JsonSerializable()
class UserDetails {
  String? email;
  String? name;
  String? uid;

  UserDetails({this.email, this.name, this.uid});
  factory UserDetails.formJson(Map<String, dynamic> data) => _$UserDetailsFormJson(data);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
