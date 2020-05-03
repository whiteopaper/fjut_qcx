import 'package:json_annotation/json_annotation.dart';

part 'keynote_model.g.dart';

@JsonSerializable()
class Keynote_model {
    Keynote_model();

    String id;
    String company_name;
    String start_time;
    String end_time;
    String place;
    String school_push_state;
    String time;
    
    factory Keynote_model.fromJson(Map<String,dynamic> json) => _$Keynote_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Keynote_modelToJson(this);
}
