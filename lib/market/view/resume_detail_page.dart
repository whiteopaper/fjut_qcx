
import 'dart:io';
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/market/widget/delete_dialog.dart';
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:flustars/flustars.dart' as FluStars;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/text_field_item.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';

class ResumeDetailPage extends StatefulWidget {

  const ResumeDetailPage({Key key, this.isAdd: true, this.uid}) : super(key: key);

  final bool isAdd;
  final String uid;

  @override
  _ResumeDetailState createState() => _ResumeDetailState();
}

class _ResumeDetailState extends State<ResumeDetailPage> {

  File _imageFile;
  UserModel _userModel;
  ResumeModel _resumeModel;
  bool _isCollect = false;
  bool _isClick = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _ipController = TextEditingController();
  TextEditingController _iwController = TextEditingController();
  TextEditingController _icController = TextEditingController();
  TextEditingController _estController = TextEditingController();
  TextEditingController _edmController = TextEditingController();
  TextEditingController _ipctController = TextEditingController();
  TextEditingController _ippController = TextEditingController();
  TextEditingController _ipdController = TextEditingController();
  TextEditingController _etController = TextEditingController();
  TextEditingController _epController = TextEditingController();
  TextEditingController _edController = TextEditingController();
  TextEditingController _hdController = TextEditingController();
  TextEditingController _scController = TextEditingController();

  ResumesPresenter presenter = ResumesPresenter();

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
    _resumeModel = ResumeModel();
    _userModel = UserModel.fromJson(FluStars.SpUtil.getObject(Constant.currentUser));
    presenter.query(
      widget.isAdd?_userModel.uid:widget.uid,
      onSuccessMap: (data){
        _resumeModel = ResumeModel.fromJson(data);
        setState(() {
          _nameController.text=_resumeModel.vsername;
          _emailController.text=_resumeModel.email;
          _mobileController.text=_resumeModel.mobile;
          _ipController.text=_resumeModel.intention_position;
          _iwController.text=_resumeModel.intention_wages;
          _icController.text=_resumeModel.intention_city;
          _estController.text=_resumeModel.education_school_time;
          _edmController.text=_resumeModel.education_department_major;
          _ipctController.text=_resumeModel.internship_company_time;
          _ippController.text=_resumeModel.internship_position;
          _ipdController.text=_resumeModel.internship_describe;
          _etController.text=_resumeModel.experience_title;
          _epController.text=_resumeModel.experience_position;
          _edController.text=_resumeModel.experience_describe;
          _hdController.text=_resumeModel.honor_describe;
          _scController.text=_resumeModel.self_comment;
          _isCollect = _resumeModel.cid!=null;
        });
      },
    );

    //监听输入改变
    _nameController.addListener(_verify);
    _emailController.addListener(_verify);
    _mobileController.addListener(_verify);
    _ipController.addListener(_verify);
    _iwController.addListener(_verify);
    _estController.addListener(_verify);
    _edmController.addListener(_verify);
  }

  void _verify() {
    String name = _nameController.text;
    String email = _emailController.text;
    String mobile = _mobileController.text;
    String ip = _ipController.text;
    String iw = _iwController.text;
    String est = _estController.text;
    String edm = _edmController.text;
    bool isClick = true;
    if (name.isEmpty||email.isEmpty||mobile.isEmpty) {
      isClick = false;
    }
    if (ip.isEmpty||iw.isEmpty||est.isEmpty||edm.isEmpty) {
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
    if (_resumeModel.id!=null){
      params["id"] = _resumeModel.id;
      params["create_time"] = _resumeModel.create_time;
      params["visit_num"] = _resumeModel.visit_num;
    }
    params["vsername"] = _nameController.text ?? '';
    params["mobile"] = _emailController.text ?? '';
    params["email"] = _mobileController.text ?? '';
    params["intention_position"] = _ipController.text ?? '';
    params["intention_wages"] = _iwController.text ?? '';
    params["intention_city"] = _icController.text ?? '';
    params["education_school_time"] = _estController.text ?? '';
    params["education_department_major"] = _edmController.text ?? '';
    params["internship_position"] = _ipctController.text ?? '';
    params["internship_company_time"] = _ippController.text ?? '';
    params["internship_describe"] = _ipdController.text ?? '';
    params["experience_title"] = _etController.text ?? '';
    params["experience_position"] = _epController.text ?? '';
    params["experience_describe"] = _edController.text ?? '';
    params["honor_describe"] = _hdController.text ?? '';
    params["self_comment"] = _scController.text ?? '';

    presenter.add(
        params,
        _resumeModel.id==null,
        onSuccess: (token){
          Toast.show('修改成功！',duration: 2000);
          NavigatorUtils.goBack(context);
        }
    ) ;

  }

  void _collection(){
    _isCollect?presenter.cancel(
        _resumeModel.id,
        onSuccess: (_){
          setState(() {
            _isCollect = !_isCollect;
          });
        }
    ): presenter.collection(
        _resumeModel.id,
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
          centerTitle: widget.isAdd ? '个人简历' : '查看简历',
          actionName: "任意",
          action:widget.isAdd?(_resumeModel.id!=null?IconButton(
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
                '基本信息',
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
              title: '真实姓名',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _nameController,
            ),
            TextFieldItem(
              title: '手机号码',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.number,
              controller: _mobileController,
            ),
            TextFieldItem(
              title: '电子邮箱',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.emailAddress,
              controller: _emailController,
            ),
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '求职意向',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: '期望岗位',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _ipController,
            ),
            TextFieldItem(
              title: '期望工资',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _iwController,
            ),
            TextFieldItem(
              title: '期望城市',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _icController,
            ),
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '教育背景',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: '毕业学校和时间',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _estController,
            ),
            TextFieldItem(
              title: '毕业院系和专业',
              hintText: "(必填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _edmController,
            ),
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '实习经历',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: '实习公司和时间',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _ipctController,
            ),
            TextFieldItem(
              title: '实习岗位',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _ippController,
            ),
            TextFieldItem(
              title: '实习描述',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _ipdController,
            ),
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '项目经验',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: '项目名',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _etController,
            ),
            TextFieldItem(
              title: '项目岗位',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _epController,
            ),
            TextFieldItem(
              title: '项目描述',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _edController,
            ),
            Gaps.vGap5,
            const Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: const Text(
                '个人经历',
                style: TextStyles.textBold18,
              ),
            ),
            Gaps.vGap16,
            TextFieldItem(
              title: '获得荣誉',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _hdController,
            ),
            TextFieldItem(
              title: '自我评价',
              hintText: "(选填)",
              enabled: widget.isAdd,
              keyboardType : TextInputType.text,
              controller: _scController,
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
        builder: (_) => DeleteDialog()
    );
  }
}
