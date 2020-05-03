import 'package:json_annotation/json_annotation.dart';

part 'recruitment_brochure_model.g.dart';

@JsonSerializable()
class Recruitment_brochure_model {
    Recruitment_brochure_model();

    String id;
    String title;
    String senddate;
    String school_push_state;
    String click;
    
    factory Recruitment_brochure_model.fromJson(Map<String,dynamic> json) => _$Recruitment_brochure_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Recruitment_brochure_modelToJson(this);
}
