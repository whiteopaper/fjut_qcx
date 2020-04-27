import 'dart:io';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fjut_qcx/provider/theme_provider.dart';
import 'package:fjut_qcx/routers/application.dart';
import 'package:fjut_qcx/routers/routers.dart';
import 'package:fjut_qcx/util/log_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'common/common.dart';
import 'home/splash_page.dart';

void main() {
//  debugProfileBuildsEnabled = true;
//  debugPaintLayerBordersEnabled = true;
//  debugProfilePaintsEnabled = true;
//  debugRepaintRainbowEnabled = true;
  runApp(MyApp());
  // 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {

  final Widget home;

  MyApp({this.home}) {
    Log.init();
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
    SpUtil.remove(Constant.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
          child: Consumer<ThemeProvider>(
            builder: (_, provider, __) {
              return MaterialApp(
                title: 'Flutter Deer',
//              showPerformanceOverlay: true, //显示性能标签
                debugShowCheckedModeBanner: false,
//              checkerboardRasterCacheImages: true,
//              showSemanticsDebugger: true, // 显示语义视图
                theme: provider.getTheme(),
                darkTheme: provider.getTheme(isDarkMode: true),
                themeMode: provider.getThemeMode(),
                home: home ?? SplashPage(),
                onGenerateRoute: Application.router.generator,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('zh', 'CH'),
                  Locale('en', 'US')
                ],
                builder: (context, child) {
                  /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                    child: child,
                  );
                },
              );
            },
          ),
        ),
        /// Toast 配置
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom
    );
  }
}
