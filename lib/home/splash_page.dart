
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/provider/theme_provider.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/image_utils.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flustars/flustars.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  int _status = 0;
  List<String> _guideList = ['a1', 'a2', 'a3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SpUtil.getInstance();
//      SpUtil.remove(Constant.accessToken);
      // 由于SpUtil未初始化，所以MaterialApp获取的为默认主题配置，这里同步一下。
      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(ImageUtils.getAssetImage(image), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1000)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeUtils.getBackgroundColor(context),
      child: _status == 0 ? FractionallyAlignedSizedBox(
        heightFactor: 0.3,
        widthFactor: 0.33,
        leftFactor: 0.33,
        bottomFactor: 0,
        child: const LoadAssetImage('qcx')
      ) :
      Swiper(
        key: const Key('swiper'),
        itemCount: _guideList.length,
        loop: false,
        itemBuilder: (_, index) {
          return LoadAssetImage(
            _guideList[index],
            key: Key(_guideList[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
        onTap: (index) {
          if (index == _guideList.length - 1) {
            _goLogin();
          }
        },
      )
    );
  }
}
