import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/widget/resumes_item.dart';
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/mine/presenter/mine_presenter.dart';
import 'package:fjut_qcx/mine/widget/exit_dialog.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/my_card.dart';
import 'package:fjut_qcx/widgets/my_scroll_view.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flustars/flustars.dart'as FlutterStars;
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  UserModel currentUser ;
  ResumeModel resumeModel ;
  StateType type = StateType.loading;
  MinePresenter presenter =  MinePresenter();


  @override
  void initState(){
    super.initState();
    currentUser = UserModel.fromJson(FlutterStars.SpUtil.getObject(Constant.currentUser));
    presenter.query(
      onSuccessMap: (data){
        setState(() {
          resumeModel = ResumeModel.fromJson(data);
        });
      },
      onError: (code,mes){
        setState(() {
          if(code == 50002) {
            type = StateType.noPermission;
          }else{
            type = StateType.resume;
          }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: "个人页",
        isBack: false,
        actionName: "注销",
        onPressed: (){
          _showExitDialog();
        },
      ),
      body: MyScrollView(

        children: <Widget>[
          Container(
            color: Colors.white,
            height: 200.0,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight - 25,
                      child: LoadAssetImage("mine/bg",format:"jpg")
                    ),
                    Positioned(
                      left: constraints.maxWidth / 2 - 25,
                      top: constraints.maxHeight - 40,
                      child: CircleAvatar(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: LoadAssetImage("recruitment/icon_avatar")
                        )
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: MyCard(
              child: Container(
              width: double.infinity,
                child: InkWell(
                  onTap: ()=>NavigatorUtils.pushResult(context, '${LoginRouter.registerNextPage}?isAdd=false', (result){
                    setState(() {
                      currentUser = result;
                    });
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Gaps.empty,
                        Text(
                            "真诚勤勇",
                            style: TextStyle(
                              fontSize: Dimens.gap_dp24,
                              color: Colours.text,
                            )
                        ),
                        Gaps.line,
                        Gaps.vGap16,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                                "Welcome！",
                                style: TextStyle(
                                  fontSize: Dimens.font_sp20,
                                  color: Colours.text,
                                )
                            ),
                            currentUser.vserName!=null?Text(
                                currentUser.vserName,
                                style: TextStyle(
                                  fontSize: Dimens.font_sp16,
                                  color: Colours.app_main,
                                )
                            ):Gaps.empty,
                          ],
                        ),
                        Gaps.vGap8,
                        Text(
                            currentUser.deptName!=null?"所在部门："+currentUser.deptName:"所在部门：点击完善个人信息",
                            style: TextStyle(
                              fontSize: Dimens.font_sp15,
                              color: Colours.text,
                            )
                        ),
                        Gaps.vGap4,
                        Text(
                            currentUser.email!=null?"电子邮箱："+currentUser.email:"电子邮箱：点击完善个人信息",
                            style: TextStyle(
                              fontSize: Dimens.font_sp15,
                              color: Colours.text,
                            )
                        ),
                        Gaps.vGap4,
                        Container(
                          height: 42,
                          child:Text(
                              currentUser.introduction!=null?"个性签名："+currentUser.introduction:"个性签名：点击完善个人信息",
                              style: TextStyle(
                                fontSize: Dimens.font_sp15,
                                color: Colours.text,
                              )
                          ),
                        ),
                      ],
                    )
                  )
                )
              )
            )
          ),
          resumeModel == null ? ( type!=StateType.resume?StateLayout(type: type):
            InkWell(
              onTap: () => NavigatorUtils.goBack(context),
              child: StateLayout(type: type) ,
            )
          ) :
          ResumesItem(
            model: resumeModel,
          )
        ],
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
        context: context,
        builder: (_) => ExitDialog()
    );
  }
}