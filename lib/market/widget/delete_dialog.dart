
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/res/styles.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/widgets/base_dialog.dart';

class DeleteDialog extends StatefulWidget {

  DeleteDialog({
    Key key,
    this.isStudent=true
  }) : super(key : key);

  final bool isStudent;

  @override
  _DeleteDialog createState() => _DeleteDialog();
  
}

class _DeleteDialog extends State<DeleteDialog> {

  ResumesPresenter presenterR = ResumesPresenter();
  WorksPresenter presenterW = WorksPresenter();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '提示',
      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: const Text('您确定要删除吗？', style: TextStyles.textSize16),
      ),
      onPressed: () {
        widget.isStudent? presenterR.delete(
            onSuccess: (_){
              Toast.show('删除成功！',duration: 2000);
              NavigatorUtils.goBack(context);
            }
        ):presenterW.delete(
            onSuccess: (_){
              Toast.show('删除成功！',duration: 2000);
              NavigatorUtils.goBack(context);
            }
        );
      },
    );
  }
}