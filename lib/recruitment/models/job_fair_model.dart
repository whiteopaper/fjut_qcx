import 'package:json_annotation/json_annotation.dart';

part 'job_fair_model.g.dart';

@JsonSerializable()
class Job_fair_model {
    Job_fair_model();

    String id;
    String name;
    String starttime;
    String endtime;
    String logopath;
    String place_name;
    String worker_name;
    String phone;
    String publicity_state;
    String click_count;
    String detail;
    
    factory Job_fair_model.fromJson(Map<String,dynamic> json) => _$Job_fair_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Job_fair_modelToJson(this);
}
