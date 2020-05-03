
import 'package:fjut_qcx/mine/view/mine_page.dart';
import 'package:fluro/fluro.dart';
import 'package:fjut_qcx/routers/router_init.dart';


class MineRouter implements IRouterProvider{

  static String minePage = '/recruitment';
  
  @override
  void initRouter(Router router) {
    router.define(minePage, handler: Handler(handlerFunc: (_, params) => MinePage()));
  }
  
}