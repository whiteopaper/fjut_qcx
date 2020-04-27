
import 'package:common_utils/common_utils.dart';
import 'package:fjut_qcx/order/models/recruit_entity.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/order/widgets/pay_type_dialog.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/util/utils.dart';
import 'package:fjut_qcx/widgets/my_card.dart';

import '../order_router.dart';

class OrderItem extends StatelessWidget {

  const OrderItem({
    Key key,
    @required this.model,
    @required this.index,
  }) : super(key: key);

  final RecruitModel model;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          child: InkWell(
            onTap: () => NavigatorUtils.push(context, OrderRouter.orderInfoPage),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                model.type=='1'? Stack(
                  alignment: const Alignment(-1.0, 1),
                  children: [
                    LoadImage(model.imgUrl,height: 150),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: Colors.black45,
                      ),
                      child: Text(
                        model.title,
                        style: TextStyle(
                          fontSize: Dimens.font_sp18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ):Gaps.empty,
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "形式："+model.recruitType,
                        style: TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Colours.text,
                        ),
                      ),
                      Gaps.vGap5,
                      Text(
                        "时间："+model.time,
                        style: TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Colours.text,
                        ),
                      ),
                      Gaps.vGap5,
                      Text(
                        "地点："+model.place,
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
  }

}

