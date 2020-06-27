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

