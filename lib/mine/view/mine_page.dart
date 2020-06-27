import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/login/login_router.dart';
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/widget/resumes_item.dart';
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/mine/presenter/mine_presenter.dart';
import 'package:fjut_qcx/mine/widget/exit_dialog.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/image_utils.dart';
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
  LoginPresenter presenter = LoginPresenter();


  @override
  void initState(){
    super.initState();
    currentUser = UserModel.fromJson(FlutterStars.SpUtil.getObject(Constant.currentUser));
    presenter.info(
      onSuccessMap: (data){
        setState(() {
          currentUser = UserModel.fromJson(data);
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
              margin: const EdgeInsets.all(3.0),
              child:MyCard(
//                color: Colors.lime,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: <Widget>[
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
                                      child:Text("亲苍霞")
                                  )
                                ],
                              ),
                            ]
                        ),
                        Gaps.vGap8,
                      ],
                    ),
                  )
              )
          ),
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
                      child: ClipOval(
                        child: Container(
                          height: 50,
                          width: 50,
                          child: currentUser.icon_path!=null
                              ? LoadImage(HttpApi.imageUrl+currentUser.icon_path)
                              : LoadAssetImage("recruitment/icon_avatar" )
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
                color: Colors.greenAccent,
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
                            "轻触下方修改个人信息",
                            style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color: Colours.text_gray,
                            )
                        ),
                        Gaps.line,
                        Gaps.vGap8,
                        Text(
                            "所在部门："+(currentUser.deptName??"待验证"),
                            style: TextStyle(
                              fontSize: Dimens.font_sp15,
                              color: Colours.text,
                            )
                        ),
                        Gaps.vGap4,
                        Text(
                            "电子邮箱："+(currentUser.email??"无"),
                            style: TextStyle(
                              fontSize: Dimens.font_sp15,
                              color: Colours.text,
                            )
                        ),
                        Gaps.vGap4,
                        Container(
                          height: 42,
                          child:Text(
                              "个性签名："+(currentUser.introduction??""),
                              style: TextStyle(
                                fontSize: Dimens.font_sp15,
                                color: Colours.text,
                              )
                          ),
                        ),
                        Gaps.vGap8,
                      ],
                    )
                  )
                )
              )
            )
          ),
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