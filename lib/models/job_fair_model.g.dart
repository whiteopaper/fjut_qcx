// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_fair_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job_fair_model _$Job_fair_modelFromJson(Map<String, dynamic> json) {
  return Job_fair_model()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..starttime = json['starttime'] as String
    ..endtime = json['endtime'] as String
    ..logopath = json['logopath'] as String
    ..place_name = json['place_name'] as String
    ..worker_name = json['worker_name'] as String
    ..phone = json['phone'] as String
    ..publicity_state = json['publicity_state'] as String
    ..click_count = json['click_count'] as String;
}

Map<String, dynamic> _$Job_fair_modelToJson(Job_fair_model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'starttime': instance.starttime,
      'endtime': instance.endtime,
      'logopath': instance.logopath,
      'place_name': instance.place_name,
      'worker_name': instance.worker_name,
      'phone': instance.phone,
      'publicity_state': instance.publicity_state,
      'click_count': instance.click_count
    };
