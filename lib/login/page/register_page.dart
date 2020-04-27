import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/login/models/auth/user_entity.dart';
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/util/utils.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  bool _isClick = false;

  LoginPresenter presenter = LoginPresenter();

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.addListener(_verify);
    _phoneController.addListener(_verify);
    _passwordController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 8) {
      isClick = false;
    }
    if (phone.isEmpty || phone.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _register() {
    String username = _nameController.text;
    String password = _passwordController.text;
    String mobile = _phoneController.text;
    presenter.register(
        username, password,mobile,
        onSuccess: (token){
          FlutterStars.SpUtil.putString(Constant.accessToken, token);
          presenter.info(
            onSuccessMap: (data){
              FlutterStars.SpUtil.putObject(Constant.currentUser, UserModel.fromJson(data));
              Toast.show('注册成功！请真实填写个人信息',duration: 5000);
              NavigatorUtils.push(context, '${LoginRouter.registerNextPage}?isAdd=true');
            }
          );
    }
    ) ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          title: '注册',
        ),
        body: MyScrollView(
          keyboardConfig: Utils.getKeyboardActionsConfig(context, [_nodeText1, _nodeText2, _nodeText3]),
          crossAxisAlignment: CrossAxisAlignment.center,
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
          children: _buildBody(),
        ),
    );
  }

  _buildBody() {
    return [
      const Text(
        '开启你的账号',
        style: TextStyles.textBold26,
      ),
      Gaps.vGap16,
      MyTextField(
        key: const Key('account'),
        focusNode: _nodeText1,
        controller: _nameController,
        maxLength: 11,
        keyboardType: TextInputType.number,
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
        hintText: '请输入密码',
      ),
      Gaps.vGap8,
      MyTextField(
        key: const Key('phone'),
        focusNode: _nodeText3,
        controller: _phoneController,
        maxLength: 11,
        keyboardType: TextInputType.phone,
        hintText: '请输入手机号',
      ),
      Gaps.vGap24,
      MyButton(
        key: const Key('register'),
        onPressed: _isClick ? _register : null,
        text: '下一步',
      )
    ];
  }
}
