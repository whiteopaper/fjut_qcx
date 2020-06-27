
import 'dart:io';
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/model/work_model.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/market/widget/delete_dialog.dart';
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/mine/widget/exit_dialog.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/base_dialog.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/popup_window.dart';
import 'package:flustars/flustars.dart' as FluStars;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/login/provider/deptment_provider.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/selected_image.dart';
import 'package:fjut_qcx/widgets/text_field_item.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';

class WorkDetailPage extends StatefulWidget {

  const WorkDetailPage({Key key, this.isAdd: true, this.uid}) : super(key: key);

  final bool isAdd;
  final String uid;

  @override
  _WorkDetailState createState() => _WorkDetailState();
}

class _WorkDetailState extends State<WorkDetailPage> {

  File _imageFile;
  UserModel _userModel;
  WorkModel _workModel;
  bool _isClick = false;
  bool _isCollect = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _wagesController = TextEditingController();
  TextEditingController _intentionController = TextEditingController();
  TextEditingController _introductionController = TextEditingController();

  WorksPresenter presenter = WorksPresenter();

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
    _workModel = WorkModel();
    _userModel = UserModel.fromJson(FluStars.SpUtil.getObject(Constant.currentUser));
    presenter.query(
      widget.isAdd?_userModel.uid:widget.uid,
      onSuccessMap: (data){
        _workModel = WorkModel.fromJson(data);
        setState(() {
          _nameController.text=_workModel.vsername;
          _emailController.text=_workModel.email;
          _mobileController.text=_workModel.mobile;
          _positionController.text=_workModel.position;
          _wagesController.text=_workModel.wages;
          _addressController.text=_workModel.address;
          _intentionController.text=_workModel.intention;
          _introductionController.text=_workModel.introduction;
          _isCollect = _workModel.cid!=null;
        });
      },
    );

    //监听输入改变
    _nameController.addListener(_verify);
    _emailController.addListener(_verify);
    _mobileController.addListener(_verify);
    _positionController.addListener(_verify);
    _wagesController.addListener(_verify);
    _intentionController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String email = _emailController.text;
    String mobile = _mobileController.text;
    String ip = _positionController.text;
    String iw = _wagesController.text;
    String est = _intentionController.text;
    bool isClick = true;
    if (name.isEmpty||email.isEmpty||mobile.isEmpty) {
      isClick = false;
    }
    if (ip.isEmpty||iw.isEmpty||est.isEmpty) {
      isClick = false;
    }
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _add() {
    Map<String, dynamic> params = Map();
    if (_workModel.id!=null){
      params["id"] = _workModel.id;
      params["create_time"] = _workModel.create_time;
      params["visit_num"] = _workModel.visit_num;
    }
    params["vsername"] = _nameController.text ?? '';
    params["mobile"] = _emailController.text ?? '';
    params["email"] = _mobileController.text ?? '';
    params["position"] = _positionController.text ?? '';
    params["address"] = _addressController.text ?? '';
    params["wages"] = _wagesController.text ?? '';
    params["intention"] = _intentionController.text ?? '';
    params["introduction"] = _introductionController.text ?? '';

    presenter.add(
        params,
        _workModel.id==null,
        onSuccess: (token){
          Toast.show('修改成功！',duration: 2000);
          NavigatorUtils.goBack(context);
        }
    ) ;

  }

  void _collection(){
    _isCollect?presenter.cancel(
        _workModel.id,
        onSuccess: (_){
          setState(() {
            _isCollect = !_isCollect;
          });
        }
    ): presenter.collection(
        _workModel.id,
        onSuccess: (_){
          setState(() {
            _isCollect = !_isCollect;
          });
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:MyAppBar(
          centerTitle: widget.isAdd ? '公司工作' : '查看工作',
          actionName: "任意",
          action:widget.isAdd?(_workModel.id!=null?IconButton(
            tooltip: '删除',
            onPressed: () {
              _showDeleteDialog();
            },
            icon: LoadAssetImage(
              'market/delete',
              key: const Key('add'),
              width: 24.0,
              height: 24.0,
            ),
          ):Gaps.empty):IconButton(
            tooltip: '收藏',
            onPressed: () {
              _collection();
            },
            icon: _isCollect?LoadAssetImage(
              'market/Collection_fill',
              key: const Key('add'),
              color: Colors.amber,
              width: 24.0,
              height: 24.0,
            ):LoadAssetImage(
              'market/Collection',
              key: const Key('add'),
              width: 24.0,
              height: 24.0,
            ),
          )

        ),
        body: MyScrollView(
          key: const Key('resumes_edit_page'),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: <Widget>[
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '企业信息',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
//            Center(
//              child: SelectedImage(
//                  size: 96.0,
//                  image: _imageFile,
//                  onTap: _getImage
//              ),
//            ),
//            Gaps.vGap8,
//            Center(
//              child: Text(
//                '点击添加个人头像',
//                style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
//              ),
//            ),
//            Gaps.vGap16,
            TextFieldItem(
              title: '企业名称',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _nameController,
            ),
            TextFieldItem(
              title: '联系号码',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.number,
              controller: _mobileController,
            ),
            TextFieldItem(
              title: '联系邮箱',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.emailAddress,
              controller: _emailController,
            ),
            TextFieldItem(
              title: '企业介绍',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _introductionController,
            ),
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '工作要求',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: '招聘岗位',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _positionController,
            ),
            TextFieldItem(
              title: '工资薪酬',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _wagesController,
            ),
            TextFieldItem(
              title: '应聘条件',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _intentionController,
            ),
            TextFieldItem(
              title: '工作地址',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _addressController,
            ),
          ],
          bottomButton: widget.isAdd?Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: MyButton(
              onPressed: _isClick ? _add : null,
              text: '提交',
            ),
          ):Gaps.empty,
        )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (_) => DeleteDialog(isStudent: false,)
    );
  }
}
