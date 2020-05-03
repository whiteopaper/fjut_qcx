// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keynote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keynote_model _$Keynote_modelFromJson(Map<String, dynamic> json) {
  return Keynote_model()
    ..id = json['id'] as String
    ..company_name = json['company_name'] as String
    ..start_time = json['start_time'] as String
    ..end_time = json['end_time'] as String
    ..place = json['place'] as String
    ..school_push_state = json['school_push_state'] as String
    ..time = json['time'] as String;
}

Map<String, dynamic> _$Keynote_modelToJson(Keynote_model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company_name': instance.company_name,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'place': instance.place,
      'school_push_state': instance.school_push_state,
      'time': instance.time
    };
