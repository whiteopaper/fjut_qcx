class UserEntity {
  int totalCount;
  List<UserModel> items;

  UserEntity({this.totalCount, this.items});

  UserEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['items'] != null) {
      items = new List<UserModel>();(json['items'] as List).forEach((v) { items.add(new UserModel.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_count'] = this.totalCount;
    if (this.items != null) {
      data['items'] =  this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  String uid;
  String name;
  String password;
  String vserName;
  String mobile;
  String createTime;
  int state;
  int deptid;
  int jobid;
  int email;
  String token;
//  List<dynamic> roles;


  UserModel(this.uid, this.name, this.password, this.vserName, this.mobile,
      this.createTime, this.state, this.deptid, this.jobid, this.email,
      this.token);

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    password = json['password'];
    vserName = json['vserName'];
    mobile = json['mobile'];
    createTime = json['createTime'];
    state = json['state'];
    deptid = json['deptid'];
    jobid = json['jobid'];
    email = json['email'];
    token = json['token'];
//    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['password'] = this.password;
    data['mobile'] = this.mobile;
    data['createTime'] = this.createTime;
    data['state'] = this.state;
    data['deptid'] = this.deptid;
    data['jobid'] = this.jobid;
    data['email'] = this.email;
    data['token'] = this.token;
//    data['roleIds'] = this.roles;
    return data;
  }
}

