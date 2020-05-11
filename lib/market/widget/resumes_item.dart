
import 'package:fjut_qcx/article/models/article_model.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/my_card.dart';


class ResumesItem extends StatelessWidget {

  const ResumesItem({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ResumeModel model;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);

    return _container(context);
  }

  Widget _container(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: MyCard(
        child: Container(
//          width: double.infinity,
          child: InkWell(
//            onTap: () => NavigatorUtils.goBack(context),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "求职意向："+model.intention_position,
                    style: TextStyle(
                      fontSize: Dimens.font_sp18,
                      color: Colours.text,
                    ),
                  ),
                  Text(
                    "期望工资："+model.intention_wages,
                    style: TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Colours.text_gray_c,
                    ),
                  ),
                  Gaps.vGap5,
                  Container(
                    height: Dimens.gap_dp50,
                    child: Text(
                      "教育背景:"+model.education_school_time+"/"+model.education_department_major,
                      style: TextStyle(
                        fontSize: Dimens.font_sp16,
                        color: Colours.text_gray,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}