
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/res/styles.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/widgets/base_dialog.dart';

class ExitDialog extends StatefulWidget {

  ExitDialog({
    Key key,
  }) : super(key : key);

  @override
  _ExitDialog createState() => _ExitDialog();
  
}

class _ExitDialog extends State<ExitDialog> {

  LoginPresenter loginPresenter = LoginPresenter();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '提示',
      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: const Text('您确定要退出登录吗？', style: TextStyles.textSize16),
      ),
      onPressed: () {
        loginPresenter.logout(
            onSuccess: (_){
              NavigatorUtils.push(context, LoginRouter.loginPage, clearStack: true);
            }
        );
      },
    );
  }
}