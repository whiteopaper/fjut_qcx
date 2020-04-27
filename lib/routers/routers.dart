
import 'package:fjut_qcx/goods/goods_router.dart';
import 'package:fjut_qcx/order/order_router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/routers/404.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/routers/router_init.dart';
import 'package:fjut_qcx/home/home_page.dart';
import 'package:fjut_qcx/home/webview_page.dart';

class Routes {

  static String home = '/home';
  static String webViewPage = '/webview';

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint('未找到目标页');
        return WidgetNotFound();
      });

    ///主界面可以在此类中进行注册（可定义传参）
    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));

    ///一些共用的界面也可以在此处注册
    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    ///每次初始化前 先清除集合 以免重复添加
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(LoginRouter());
    _listRouter.add(GoodsRouter());
    _listRouter.add(OrderRouter());
  
    /// 初始化路由 循环遍历取出每个子router进行初始化操作
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
