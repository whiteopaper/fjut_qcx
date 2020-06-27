// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel()
    ..uid = json['uid'] as String
    ..name = json['name'] as String
    ..password = json['password'] as String
    ..vserName = json['vserName'] as String
    ..mobile = json['mobile'] as String
    ..createTime = json['createTime'] as String
    ..state = json['state'] as num
    ..email = json['email'] as String
    ..avatar = json['avatar'] as String
    ..introduction = json['introduction'] as String
    ..token = json['token'] as String
    ..deptName = json['deptName'] as String
    ..icon_path = json['icon_path'] as String
    ..license_path = json['license_path'] as String;
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'password': instance.password,
      'vserName': instance.vserName,
      'mobile': instance.mobile,
      'createTime': instance.createTime,
      'state': instance.state,
      'email': instance.email,
      'avatar': instance.avatar,
      'introduction': instance.introduction,
      'token': instance.token,
      'deptName': instance.deptName,
      'icon_path': instance.icon_path,
      'license_path': instance.license_path
    };
