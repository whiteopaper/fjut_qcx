import 'package:fjut_qcx/login/models/auth/user_entity.dart';
import 'package:fjut_qcx/login/models/department_entity.dart';
import 'package:fjut_qcx/order/models/search_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == 'SearchEntity') {
      return SearchEntity.fromJson(json) as T;
    } else if (T.toString() == 'DepartmentModel') {
      return DepartmentModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}