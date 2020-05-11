import 'package:json_annotation/json_annotation.dart';

part 'resume_model.g.dart';

@JsonSerializable()
class Resume_model {
    Resume_model();

    String id;
    String user_id;
    String intention_position;
    String intention_city;
    String intention_wages;
    String education_school_time;
    String education_department_major;
    String internship_company_time;
    String internship_position;
    String internship_describe;
    String experience_title;
    String experience_position;
    String experience_describe;
    String honor_describe;
    String self_comment;
    String create_time;
    num visit_num;
    
    factory Resume_model.fromJson(Map<String,dynamic> json) => _$Resume_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Resume_modelToJson(this);
}
