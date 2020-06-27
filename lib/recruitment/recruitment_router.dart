
import 'package:fjut_qcx/recruitment/widgets/recruitment_detail.dart';
import 'package:fluro/fluro.dart';
import 'package:fjut_qcx/routers/router_init.dart';

import 'view/recruitment_page.dart';


class RecruitmentRouter implements IRouterProvider{

  static String recruitmentPage = '/recruitment';
  static String recruitmentDetail = '/recruitmentDetail';
  
  @override
  void initRouter(Router router) {
    router.define(recruitmentPage, handler: Handler(handlerFunc: (_, params) => RecruitmentPage()));
    router.define(recruitmentDetail, handler: Handler(handlerFunc: (_, params) {
      String data = params['data']?.first;
      return RecruitmentDetail(data: data,);
    } ));
  }
  
}