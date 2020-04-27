class DepartmentEntity {
  int totalCount;
  List<DepartmentModel> items;

  DepartmentEntity({this.totalCount, this.items});

  DepartmentEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    if (json['items'] != null) {
      items = new List<DepartmentModel>();(json['items'] as List).forEach((v) { items.add(new DepartmentModel.fromJson(v)); });
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

class DepartmentModel {
  int id;
  String name;
  List childrens;


  DepartmentModel(this.id, this.name, this.childrens);

  DepartmentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    childrens = json['childrens'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['childrens'] = this.childrens;
    return data;
  }
}

