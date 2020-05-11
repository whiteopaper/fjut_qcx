
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/widgets/my_button.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:fjut_qcx/widgets/text_field_item.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/theme_utils.dart';

import 'market_list_page.dart';


class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>  {

  TextEditingController _majorController = new TextEditingController();
  TextEditingController _positionController = new TextEditingController();

  LoginPresenter presenter = LoginPresenter();

  bool hasProve = false;
  bool isStudent = true;
  
  @override
  void initState() {
    super.initState();
    presenter.isRole(
      13,
      onSuccess: (data){
        setState(() {
          isStudent = true;
          hasProve = true;
        });
      },
      onError: (code,msg){
//        if(code == 50002) {
//          setState(() {
//            hasProve = false;
//          });
//        }
        if(code == 50000){
          setState(() {
            Toast.cancelToast();
            isStudent = false;
            hasProve = true;
          });
        }
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Gaps.vGap4
          ],
        ),
        body: hasProve?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //TabBar
            Container(
              padding: EdgeInsets.only(left: 16.0),
              color: ThemeUtils.getBackgroundColor(context),
              child: isStudent?_WorkSearchView(
                mController: _majorController,
                pController: _positionController,
              ):_ResumeSearchView(
                mController: _majorController,
                pController: _positionController,
              )
            ),
            Gaps.line,
            //List
            Expanded(
              child: isStudent?MarketListPage<ResumeModel>(isStudent: isStudent,):MarketListPage<ResumeModel>(isStudent: isStudent),
            )
          ],
        ):StateLayout(type: StateType.noPermission)
    );
  }

}

class _ResumeSearchView extends StatelessWidget {

  const _ResumeSearchView({
    Key key,
    this.mController,
    this.pController,
  }): super(key: key);
  final TextEditingController mController;
  final TextEditingController pController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFieldItem(
          title: '院系专业：',
          hintText: '例：计算机',
          keyboardType : TextInputType.text,
          controller: mController,
        ),
        TextFieldItem(
          title: '意向岗位：',
          hintText: '例：JAVA',
          keyboardType : TextInputType.text,
          controller: pController,
        ),
        MyButton(
            text:"查询",
            onPressed:(){

            }
        )
      ],
    );
  }
}

class _WorkSearchView extends StatelessWidget {

  const _WorkSearchView({
    Key key,
    this.mController,
    this.pController,
  }): super(key: key);
  final TextEditingController mController;
  final TextEditingController pController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFieldItem(
          title: '院系专业：',
          hintText: '例：计算机',
          keyboardType : TextInputType.text,
          controller: mController,
        ),
        TextFieldItem(
          title: '意向岗位：',
          hintText: '例：JAVA',
          keyboardType : TextInputType.text,
          controller: pController,
        ),
        MyButton(
            text:"查询",
            onPressed:(){

            }
        )
      ],
    );
  }
}
