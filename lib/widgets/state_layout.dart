
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/image_utils.dart';
import 'package:fjut_qcx/util/theme_utils.dart';

class StateLayout extends StatefulWidget {
  
  const StateLayout({
    Key key,
    @required this.type,
    this.hintText
  }):super(key: key);
  
  final StateType type;
  final String hintText;
  
  @override
  _StateLayoutState createState() => _StateLayoutState();
}

class _StateLayoutState extends State<StateLayout> {
  
  String _img;
  String _hintText;
  
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case StateType.recruitment:
        _img = 'zwdd';
        _hintText = '暂无招聘信息';
        break;
      case StateType.resume:
        _img = 'add';
        _hintText = '点击添加个人简历';
        break;
      case StateType.noPermission:
        _img = 'sorry';
        _hintText = '等待通过学校的身份验证';
        break;
      case StateType.network:
        _img = 'zwwl';
        _hintText = '无网络连接';
        break;
      case StateType.message:
        _img = 'zwxx';
        _hintText = '暂无消息';
        break;
      case StateType.loading:
        _img = '';
        _hintText = '';
        break;
      case StateType.empty:
        _img = '';
        _hintText = '';
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        widget.type == StateType.loading ? const CupertinoActivityIndicator(radius: 16.0) :
        (widget.type == StateType.empty ? Gaps.empty :
        Opacity(
          opacity: ThemeUtils.isDark(context) ? 0.5 : 1,
          child: Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageUtils.getAssetImage('state/$_img'),
              ),
            ),
          ))
        ),
        const SizedBox(width: double.infinity, height: Dimens.gap_dp16,),
        Text(
          widget.hintText ?? _hintText,
          style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap50,
      ],
    );
  }
}

enum StateType {
  /// 学校招聘
  recruitment,
  /// 简历添加
  resume,
  /// 无权限
  noPermission,
  /// 网络
  network,
  /// 信息
  message,
  /// 加载中
  loading,
  /// 空
  empty
}