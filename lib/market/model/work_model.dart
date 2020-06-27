import 'package:json_annotation/json_annotation.dart';

part 'work_model.g.dart';

@JsonSerializable()
class WorkModel {
    WorkModel();

    String id;
    String user_id;
    String vsername;
    String mobile;
    String email;
    String position;
    String address;
    String wages;
    String intention;
    String introduction;
    String create_time;
    num visit_num;
    int cid;
    
    factory WorkModel.fromJson(Map<String,dynamic> json) => _$Work_modelFromJson(json);
    Map<String, dynamic> toJson() => _$Work_modelToJson(this);
}
