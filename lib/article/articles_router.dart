
import 'package:fluro/fluro.dart';
import 'package:fjut_qcx/routers/router_init.dart';

import 'view/articles_page.dart';


class ArticlesRouter implements IRouterProvider{

  static String articlesPage = '/articles';
  
  @override
  void initRouter(Router router) {
    router.define(articlesPage, handler: Handler(handlerFunc: (_, params) => ArticlesPage()));
  }
  
}