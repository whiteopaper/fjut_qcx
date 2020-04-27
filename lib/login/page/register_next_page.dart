
import 'dart:io';
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/login/models/auth/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:image_picker/image_picker.dart';
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/goods/provider/goods_sort_provider.dart';
import 'package:fjut_qcx/login/widgets/goods_sort_dialog.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/widgets/click_item.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/selected_image.dart';
import 'package:fjut_qcx/widgets/text_field_item.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';

class RegisterNextPage extends StatefulWidget {

  const RegisterNextPage({Key key, this.isAdd: true}) : super(key: key);

  final bool isAdd;

  @override
  _RegisterNextState createState() => _RegisterNextState();
}

class _RegisterNextState extends State<RegisterNextPage> {

  File _imageFile;
  int _departmentId;
  String _departmentName;

  bool _isClick = false;

  TextEditingController _vsernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  LoginPresenter presenter = LoginPresenter();

  void _getImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800);
      setState(() {});
    } catch (e) {
      Toast.show('没有权限，无法打开相册！');
    }
  }

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _vsernameController.addListener(_verify);
  }
  void _verify() {
    String vsername = _vsernameController.text;
    bool isClick = true;
    if (vsername.isEmpty || vsername.length > 4) {
      isClick = false;
    }
    if (_departmentName == null || _departmentName.isEmpty ) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _register() {
    String vsername = _vsernameController.text;
    String email = _emailController.text ?? '';
    UserModel currentUser = UserModel.fromJson(FlutterStars.SpUtil.getObject(Constant.currentUser));
    presenter.registerNext(
        currentUser , vsername, email ,_departmentId,
        onSuccess: (token){
          Toast.show('完善成功！请登录···',duration: 2000);
          NavigatorUtils.push(context, LoginRouter.loginPage);
        }
    ) ;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          centerTitle: widget.isAdd ? '完善个人信息' : '修改个人信息',
          onPressedBack: () {
            Toast.cancelToast();
            NavigatorUtils.push(context, LoginRouter.loginPage);
          },
        ),
        body: MyScrollView(
          key: const Key('goods_edit_page'),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: <Widget>[
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '基本信息',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            Center(
              child: SelectedImage(
                  size: 96.0,
                  image: _imageFile,
                  onTap: _getImage
              ),
            ),
            Gaps.vGap8,
            Center(
              child: Text(
                '点击添个人头像',
                style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
              ),
            ),
            Gaps.vGap16,
            Stack(
                alignment: Alignment(-0.64, -0.3),
                children: <Widget>[
                  TextFieldItem(
                    title: '真实姓名',
                    hintText: '填写真实姓名',
//                    keyboardType : TextInputType.multiline,
                    controller: _vsernameController,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Semantics(
                        child: LoadAssetImage('login/Required',
                          width: 10.0,
                          height: 10.0,
                        ),
                      ),
                    ],
                  )
                ]
            ),

            TextFieldItem(
              title: '电子邮件',
              hintText: '选填',
              keyboardType : TextInputType.emailAddress,
              controller: _emailController,
            ),
            Gaps.vGap16,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '身份验证',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            Stack(
                alignment: Alignment(-0.63, -0.3),
                children: <Widget>[
                  ClickItem(
                    title: '所属部门',
                    content: _departmentName ?? '选择部门',
                    onTap: () => _showBottomSheet(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Semantics(
                        child: LoadAssetImage('login/Required',
                          width: 10.0,
                          height: 10.0,
                        ),
                      ),
                    ],
                  )
                ]
            ),
            Gaps.vGap8,
          ],
          bottomButton: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: MyButton(
              onPressed: _isClick ? _register : null,
              text: '提交',
            ),
          ),
        )
    );
  }

  GoodsSortProvider _provider = GoodsSortProvider();

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      /// 使用true则高度不受16分之9的最高限制
      isScrollControlled: true,
      builder: (BuildContext context) {
        return GoodsSortDialog(
          provider: _provider,
          onSelected: (id, name) {
            setState(() {
              _departmentId = id;
              _departmentName = name;
            });
          },
        );
      },
    );
  }
}
