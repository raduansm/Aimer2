// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFormJson(Map<String, dynamic> json) {
  return UserDetails(
    email: json['email'] as String?,
    name: json['name'] as String?,
    uid: json['uid'] as String?,
  );
}

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'uid': instance.uid,
    };
