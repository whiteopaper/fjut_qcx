// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruitment_brochure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recruitment_brochure_model _$Recruitment_brochure_modelFromJson(
    Map<String, dynamic> json) {
  return Recruitment_brochure_model()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..senddate = json['senddate'] as String
    ..school_push_state = json['school_push_state'] as String
    ..click = json['click'] as String;
}

Map<String, dynamic> _$Recruitment_brochure_modelToJson(
        Recruitment_brochure_model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'senddate': instance.senddate,
      'school_push_state': instance.school_push_state,
      'click': instance.click
    };
