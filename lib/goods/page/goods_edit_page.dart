
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fjut_qcx/goods/provider/goods_sort_provider.dart';
import 'package:fjut_qcx/goods/widgets/goods_sort_dialog.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/util/utils.dart';
import 'package:fjut_qcx/widgets/click_item.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/selected_image.dart';
import 'package:fjut_qcx/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';

/// design/4商品/index.html#artboard5
class GoodsEditPage extends StatefulWidget {
  
  const GoodsEditPage({Key key, this.isAdd: true, this.isScan: false}) : super(key: key);
  
  final bool isAdd;
  final bool isScan;
  
  @override
  _GoodsEditPageState createState() => _GoodsEditPageState();
}

class _GoodsEditPageState extends State<GoodsEditPage> {

  File _imageFile;
  String _goodsSortName;
  final TextEditingController _codeController = TextEditingController();
  
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isScan) {
        _scan();
      }
    });
  }
  
  void _scan() async {
    String code = await Utils.scan();
    if (code != null) {
      _codeController.text = code;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: widget.isAdd ? '完善个人信息' : '修改个人信息',
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
                  content: _goodsSortName ?? '选择部门',
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
            onPressed: () => NavigatorUtils.goBack(context),
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
          onSelected: (_, name) {
            setState(() {
              _goodsSortName = name;
            });
          },
        );
      },
    );
  }
}
