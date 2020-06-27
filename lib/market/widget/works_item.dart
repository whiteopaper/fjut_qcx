
import 'package:fjut_qcx/article/models/article_model.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/model/work_model.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/my_card.dart';

import '../market_router.dart';


class WorksItem extends StatelessWidget {

  const WorksItem({
    Key key,
    @required this.model,
  }) : super(key: key);

  final WorkModel model;

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
            onTap: () => NavigatorUtils.push(context, '${MarketRouter.workDetailPage}?isAdd=false&uid=${model.user_id}'),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "招聘岗位："+model.position,
                    style: TextStyle(
                      fontSize: Dimens.font_sp18,
                      color: Colours.text,
                    ),
                  ),
                  Text(
                    "工资薪酬："+model.wages,
                    style: TextStyle(
                      fontSize: Dimens.font_sp14,
                      color: Colours.text_gray_c,
                    ),
                  ),
                  Gaps.vGap5,
                  Container(
                    height: Dimens.gap_dp50,
                    child: Text(
                      "应聘条件:"+model.intention,
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