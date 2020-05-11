import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
    UserModel();

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
    
    factory UserModel.fromJson(Map<String,dynamic> json) => _$UserModelFromJson(json);
    Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
