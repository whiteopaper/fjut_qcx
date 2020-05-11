import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User_model {
    User_model();

    String uid;
    String name;
    String password;
    String vserName;
    String mobile;
    String createTime;
    num state;
    String email;
    String avatar;
    String introduction;
    String token;
    String deptName;
    
    factory User_model.fromJson(Map<String,dynamic> json) => _$User_modelFromJson(json);
    Map<String, dynamic> toJson() => _$User_modelToJson(this);
}
