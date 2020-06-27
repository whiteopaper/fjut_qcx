
import 'package:fjut_qcx/article/models/article_model.dart';
import 'package:fjut_qcx/login/models/department_entity.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/model/work_model.dart';
import 'package:fjut_qcx/recruitment/models/job_fair_model.dart';
import 'package:fjut_qcx/recruitment/models/keynote_model.dart';
import 'package:fjut_qcx/recruitment/models/recruitment_brochure_model.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == 'Job_fair_model') {
      return Job_fair_model.fromJson(json) as T;
    } else if (T.toString() == 'Keynote_model') {
      return Keynote_model.fromJson(json) as T;
    } else if (T.toString() == 'Recruitment_brochure_model') {
      return Recruitment_brochure_model.fromJson(json) as T;
    } else if (T.toString() == 'ArticleModel') {
      return ArticleModel.fromJson(json) as T;
    } else if (T.toString() == 'ResumeModel') {
      return ResumeModel.fromJson(json) as T;
    } else if (T.toString() == 'WorkModel') {
      return WorkModel.fromJson(json) as T;
    } else if (T.toString() == 'DepartmentModel') {
      return DepartmentModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}