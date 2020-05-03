
import 'package:fluro/fluro.dart';
import 'package:fjut_qcx/routers/router_init.dart';

import 'view/recruitment_page.dart';


class RecruitmentRouter implements IRouterProvider{

  static String recruitmentPage = '/recruitment';
  
  @override
  void initRouter(Router router) {
    router.define(recruitmentPage, handler: Handler(handlerFunc: (_, params) => RecruitmentPage()));
  }
  
}