
import 'package:fluro/fluro.dart';
import 'package:fjut_qcx/routers/router_init.dart';

import 'view/market_page.dart';


class MarketRouter implements IRouterProvider{

  static String marketPage = '/market';
  
  @override
  void initRouter(Router router) {
    router.define(marketPage, handler: Handler(handlerFunc: (_, params) => MarketPage()));
  }
  
}