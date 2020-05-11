
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
    if (json.containsKey(Constant.code)){
      code = json[Constant.code];
    }
    if (json.containsKey(Constant.message)){
      message = json[Constant.message];
    }
    if (json.containsKey(Constant.data)) {
      if (json[Constant.data] is List) {
        (json[Constant.data] as List).forEach((value) {
          listData.add(_generateOBJ<T>(value));
        });
      } else if (json[Constant.data] is Map) {
        mapData = (json[Constant.data] as Map);
      } else {
        data = _generateOBJ(json[Constant.data]);
      }
    }

    if (json.containsKey(Constant.jobfairList)) {
      code = Constant.CODE_200;
      (json[Constant.jobfairList] as List).forEach((value) {
        listData.add(_generateOBJ<T>(value));
      });
    }
    if (json.containsKey(Constant.keynoteList)) {
      code = Constant.CODE_200;
      (json[Constant.keynoteList] as List).forEach((value) {
        listData.add(_generateOBJ<T>(value));
      });
    }
    if (json.containsKey(Constant.dataList)) {
      code = Constant.CODE_200;
      (json[Constant.dataList] as List).forEach((value) {
        listData.add(_generateOBJ<T>(value));
      });
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