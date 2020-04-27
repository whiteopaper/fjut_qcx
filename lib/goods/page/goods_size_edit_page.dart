
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/selected_image.dart';
import 'package:fjut_qcx/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';

/// design/4商品/index.html#artboard14
class GoodsSizeEditPage extends StatefulWidget {
  
  @override
  _GoodsSizeEditPageState createState() => _GoodsSizeEditPageState();
}

class _GoodsSizeEditPageState extends State<GoodsSizeEditPage> {

  File _imageFile;

  void _getImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);
      setState(() {});
    } catch (e) {
      Toast.show('没有权限，无法打开相册！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '规格分类',
      ),
      body: MyScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: <Widget>[
          Gaps.vGap5,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('基本信息', style: TextStyles.textBold18),
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
              '点击添加分类图片',
              style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
          Gaps.vGap16,
          TextFieldItem(
            title: '分类名称',
            hintText: '填写该分类名称',
          ),
          TextFieldItem(
            title: '折后价格',
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            hintText: '填写该分类折后价格',
          ),
          TextFieldItem(
            title: '库存数量',
            hintText: '填写该分类库存数量',
            keyboardType: TextInputType.number
          ),
          TextFieldItem(
            title: '佣金金额',
            keyboardType: TextInputType.numberWithOptions(decimal: true)
          ),
          TextFieldItem(
            title: '起购数量',
            keyboardType: TextInputType.number
          ),
          Gaps.vGap32,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('折扣立减', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          TextFieldItem(
              title: '立减金额',
              keyboardType: TextInputType.number
          ),
          TextFieldItem(
              title: '抵扣金额',
              keyboardType: TextInputType.number
          ),
          Gaps.vGap8,
        ],
        bottomButton: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: MyButton(
            onPressed: () => NavigatorUtils.goBack(context),
            text: '确定',
          ),
        ),
      )
    );
  }
  
}
