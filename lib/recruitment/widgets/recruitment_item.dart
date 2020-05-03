
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/my_card.dart';
import 'package:fjut_qcx/recruitment/models/job_fair_model.dart';
import 'package:fjut_qcx/recruitment/models/keynote_model.dart';
import 'package:fjut_qcx/recruitment/models/recruitment_brochure_model.dart';

import '../recruitment_router.dart';

class RecruitmentItem extends StatelessWidget {

  const RecruitmentItem({
    Key key,
    @required this.model,
    @required this.index,
    @required this.tabIndex,
  }) : super(key: key);

  final Map<String,dynamic> model;
  final int index;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: _container(context),
      )
    );
  }

  Widget _container(BuildContext context) {
//    if(context.widget.widget){
//      return context.widget;
//    }
    if (tabIndex ==0){
      Job_fair_model modelJ = model['$tabIndex+$index'];
      return Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: MyCard(
            child: Container(
              child: InkWell(
                onTap: () => NavigatorUtils.goWebViewPage(
                  context,
                  modelJ.name,
                  HttpApi.jobfairDetails+modelJ.id
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: const Alignment(-1.0, 1),
                      children: [
                        LoadImage(modelJ.logopath,height: 150,width: double.infinity,),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.black45,
                          ),
                          child: Text(
                            modelJ.name,
                            style: TextStyle(
                              fontSize: Dimens.font_sp18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "举办形式："+ (modelJ.place_name==''?"网络招聘会":"校园招聘会"),
                            style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text,
                            ),
                          ),
                          Gaps.vGap5,
                          Text(
                            "举办时间："+modelJ.starttime+"-"+modelJ.endtime,
                            style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text,
                            ),
                          ),
                          Gaps.vGap5,
                          modelJ.place_name!=''?Text(
                            "举办地点："+modelJ.place_name,
                            style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text,
                            ),
                          ):Gaps.empty
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    } else if (tabIndex ==1){
      Keynote_model modelK = model['$tabIndex+$index'];
      return Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: MyCard(
            child: Container(
              child: InkWell(
                onTap: () => NavigatorUtils.goWebViewPage(
                    context,
                    modelK.company_name,
                    HttpApi.keynoteDetails+modelK.id
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: const Alignment(-1.0, 1),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.black45,
                          ),
                          child: Text(
                            modelK.company_name,
                            style: TextStyle(
                              fontSize: Dimens.font_sp18,
                              color: Colors.lime,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "举办时间："+modelK.time,
                            style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text,
                            ),
                          ),
                          Gaps.vGap5,
                          Text(
                            "举办地点："+modelK.place,
                            style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    } else if (tabIndex ==2){
      Recruitment_brochure_model modelR = model['$tabIndex+$index'];
      return Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: MyCard(
            child: Container(
              child: InkWell(
                onTap: () => NavigatorUtils.goWebViewPage(
                    context,
                    modelR.title,
                    HttpApi.brochureDetails+modelR.id
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      alignment: const Alignment(-1.0, 1),
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.black45,
                          ),
                          child: Text(
                            modelR.title,
                            style: TextStyle(
                              fontSize: Dimens.font_sp18,
                              color: Colors.lightGreen,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "举办时间："+modelR.senddate,
                            style: TextStyle(
                              fontSize: Dimens.font_sp14,
                              color: Colours.text,
                            ),
                          ),
                          Gaps.vGap5,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      );
    } else {
      return null;
    }
  }

}

