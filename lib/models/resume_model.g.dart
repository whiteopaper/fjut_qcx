// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resume_model _$Resume_modelFromJson(Map<String, dynamic> json) {
  return Resume_model()
    ..id = json['id'] as String
    ..user_id = json['user_id'] as String
    ..intention_position = json['intention_position'] as String
    ..intention_city = json['intention_city'] as String
    ..intention_wages = json['intention_wages'] as String
    ..education_school_time = json['education_school_time'] as String
    ..education_department_major = json['education_department_major'] as String
    ..internship_company_time = json['internship_company_time'] as String
    ..internship_position = json['internship_position'] as String
    ..internship_describe = json['internship_describe'] as String
    ..experience_title = json['experience_title'] as String
    ..experience_position = json['experience_position'] as String
    ..experience_describe = json['experience_describe'] as String
    ..honor_describe = json['honor_describe'] as String
    ..self_comment = json['self_comment'] as String
    ..create_time = json['create_time'] as String
    ..visit_num = json['visit_num'] as num;
}

Map<String, dynamic> _$Resume_modelToJson(Resume_model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'intention_position': instance.intention_position,
      'intention_city': instance.intention_city,
      'intention_wages': instance.intention_wages,
      'education_school_time': instance.education_school_time,
      'education_department_major': instance.education_department_major,
      'internship_company_time': instance.internship_company_time,
      'internship_position': instance.internship_position,
      'internship_describe': instance.internship_describe,
      'experience_title': instance.experience_title,
      'experience_position': instance.experience_position,
      'experience_describe': instance.experience_describe,
      'honor_describe': instance.honor_describe,
      'self_comment': instance.self_comment,
      'create_time': instance.create_time,
      'visit_num': instance.visit_num
    };
