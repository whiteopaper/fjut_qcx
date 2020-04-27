class RecruitEntity {
  int totalCount;
  List<RecruitModel> items;

  RecruitEntity({this.totalCount, this.items});

  RecruitEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['items'] != null) {
      items = new List<RecruitModel>();(json['items'] as List).forEach((v) { items.add(new RecruitModel.fromJson(v)); });
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

class RecruitModel {
  String type;//1.招聘会 2.宣讲会 3.招聘简章
  String title;
  String imgUrl;
  String recruitType;
  String time;
  String place;
  String detail;


  RecruitModel(this.type, this.title, this.imgUrl, this.recruitType, this.time,
      this.place, this.detail);

  RecruitModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    imgUrl = json['imgUrl'];
    recruitType = json['recruitType'];
    time = json['time'];
    place = json['place'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['title'] = this.title;
    data['time'] = this.time;
    data['place'] = this.place;
    data['detail'] = this.detail;
    return data;
  }
}

