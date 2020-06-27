
import 'package:fjut_qcx/market/view/resume_search_page.dart';
import 'package:fjut_qcx/market/view/resume_detail_page.dart';
import 'package:fjut_qcx/market/view/work_detail_page.dart';
import 'package:fjut_qcx/market/view/work_search_page.dart';
import 'package:fluro/fluro.dart';
import 'package:fjut_qcx/routers/router_init.dart';

import 'view/market_page.dart';


class MarketRouter implements IRouterProvider{

  static String marketPage = '/marketPage';
  static String resumeSearchPage = '/resumeSearchPage';
  static String workSearchPage = '/workSearchPage';
  static String resumeDetailPage = '/resumeDetailPage';
  static String workDetailPage = '/workDetailPage';
  
  @override
  void initRouter(Router router) {
    router.define(marketPage, handler: Handler(handlerFunc: (_, params) => MarketPage()));
    router.define(resumeSearchPage, handler: Handler(handlerFunc: (_, params) => ResumeSearchPage()));
    router.define(workSearchPage, handler: Handler(handlerFunc: (_, params) => WorkSearchPage()));
    router.define(resumeDetailPage, handler: Handler(handlerFunc: (_, params) {
      bool isAdd = params['isAdd']?.first == 'true';
      String uid = params['uid']?.first;
      return ResumeDetailPage(isAdd: isAdd,uid: uid,);
    }));
    router.define(workDetailPage, handler: Handler(handlerFunc: (_, params) {
      bool isAdd = params['isAdd']?.first == 'true';
      String uid = params['uid']?.first;
      return WorkDetailPage(isAdd: isAdd,uid: uid,);
    }));
  }
  
}