// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Work_model _$Work_modelFromJson(Map<String, dynamic> json) {
  return Work_model()
    ..id = json['id'] as String
    ..user_id = json['user_id'] as String
    ..vsername = json['vsername'] as String
    ..mobile = json['mobile'] as String
    ..email = json['email'] as String
    ..position = json['position'] as String
    ..address = json['address'] as String
    ..wages = json['wages'] as String
    ..intention = json['intention'] as String
    ..introduction = json['introduction'] as String
    ..create_time = json['create_time'] as String
    ..visit_num = json['visit_num'] as num;
}

Map<String, dynamic> _$Work_modelToJson(Work_model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'vsername': instance.vsername,
      'mobile': instance.mobile,
      'email': instance.email,
      'position': instance.position,
      'address': instance.address,
      'wages': instance.wages,
      'intention': instance.intention,
      'introduction': instance.introduction,
      'create_time': instance.create_time,
      'visit_num': instance.visit_num
    };
