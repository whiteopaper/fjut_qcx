import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/routers/routers.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/utils.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/text_field.dart';

import '../login_router.dart';


class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;

  LoginPresenter presenter = LoginPresenter();

  @override
  void initState() {
    super.initState();
    FlutterStars.SpUtil.remove(Constant.accessToken);
    //监听输入改变  
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
  }

  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 8) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }
  
  void _login() async{
    FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
    String username = _nameController.text;
    String password = _passwordController.text;
    presenter.login(
      username, password,onSuccess: (token){
        FlutterStars.SpUtil.putString(Constant.accessToken, token);
        presenter.info(
            onSuccessMap: (data){
              FlutterStars.SpUtil.putObject(Constant.currentUser, UserModel.fromJson(data));
            }
        );
        NavigatorUtils.push(context, Routes.home, clearStack: true);
      }
    ) ;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isBack: false,
//        actionName: '验证码登录',
//        onPressed: () {
//          NavigatorUtils.push(context, '${GoodsRouter.goodsEditPage}?isAdd=true');
//        },
      ),
      body: MyScrollView(
        keyboardConfig: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2]),
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        children: _buildBody,
      ),
    );
  }
  
  get _buildBody => [
    Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget>[
          LoadAssetImage(
            'fjut',
            height:50 ,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:<Widget>[
              Container(
                height:35,
                child:LoadAssetImage(
                  'qcx',
                )
              ),
              Container(
//                height: 20,
                child:Text("亲苍霞")
              )
            ],
          ),
      ]
    ),

    Gaps.vGap16,
    MyTextField(
      key: const Key('phone'),
      focusNode: _nodeText1,
      controller: _nameController,
      maxLength: 11,
      keyboardType: TextInputType.number,
      icon: Icon(Icons.account_circle),
      hintText: '请输入账号',
    ),
    Gaps.vGap8,
    MyTextField(
      key: const Key('password'),
      keyName: 'password',
      focusNode: _nodeText2,
      isInputPwd: true,
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      maxLength: 16,
      icon: Icon(Icons.lock),
      hintText: '请输入密码',
    ),
    Gaps.vGap24,
    MyButton(
      key: const Key('login'),
      onPressed: _isClick ? _login : null,
      text: '登录',
    ),
    Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Text(
                '注册账号',
                style:Theme.of(context).textTheme.subtitle,
              ),
              onTap: () => NavigatorUtils.push(context, LoginRouter.registerPage),
            ),

            GestureDetector(
              child: Text(
                '忘记密码',
                style: Theme.of(context).textTheme.subtitle,
                ),
              onTap: () => NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
            ),
        ],
      ) ,
    ),
  ];

}
