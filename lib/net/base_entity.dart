
import 'package:fjut_qcx/common/common.dart';

import 'package:fjut_qcx/net/entity_factory.dart';

class BaseEntity<T> {

  int code;
  String message;
  T data;
  List<T> listData = [];
  List list = [];
  Map<String, dynamic> mapData = {};

  BaseEntity(this.code, this.message, this.data);

  BaseEntity.fromJson(Map<String, dynamic> json) {
    code = json[Constant.code];
    message = json[Constant.message];
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        list =  (json[Constant.data] as List);
      } else if (json[Constant.data] is Map) {
        mapData = (json[Constant.data] as Map);
        (json[Constant.data] as Map).forEach((key,value) {
          listData.add(_generateOBJ<T>(value));
        });
      } else {
        data = _generateOBJ(json[Constant.data]);
      }
    }
  }

  S _generateOBJ<S>(json) {
    if (S.toString() == 'String') {
      return json.toString() as S;
    } else if (T.toString() == 'Map<dynamic, dynamic>') {
      return json as S;
    } else {
      return EntityFactory.generateOBJ(json);
    }
  }
}