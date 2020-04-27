
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/order/widgets/pay_type_dialog.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:fjut_qcx/util/utils.dart';
import 'package:fjut_qcx/widgets/my_card.dart';

import '../order_router.dart';

class FairItem extends StatelessWidget {

  const FairItem({
    Key key,
    @required this.tabIndex,
    @required this.index,
  }) : super(key: key);

  final int tabIndex;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () => NavigatorUtils.push(context, OrderRouter.orderInfoPage),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('15000000000（郭李）'),
                    ),
                    Text(
                      '货到付款',
                      style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: Theme.of(context).errorColor
                      ),
                    ),
                  ],
                ),
                Gaps.vGap8,
                Text(
                  '西安市雁塔区 鱼化寨街道唐兴路唐兴数码3楼318',
                  style: Theme.of(context).textTheme.subtitle,
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(text: '清凉一度抽纸'),
                        TextSpan(text: '  x1', style: Theme.of(context).textTheme.subtitle),
                      ],
                    )
                ),
                Gaps.vGap8,
                RichText(
                    text: TextSpan(
                      style: textTextStyle,
                      children: <TextSpan>[
                        TextSpan(text: '清凉一度抽纸'),
                        TextSpan(text: '  x2', style: Theme.of(context).textTheme.subtitle),
                      ],
                    )
                ),
                Gaps.vGap12,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                            style: textTextStyle,
                            children: <TextSpan>[
                              TextSpan(text: Utils.formatPrice('20.00', format: MoneyFormat.NORMAL)),
                              TextSpan(text: '  共3件商品', style: Theme.of(context).textTheme.subtitle.copyWith(fontSize: Dimens.font_sp10)),
                            ],
                          )
                      ),
                    ),
                    Text(
                      '2018.02.05 10:00',
                      style: TextStyles.textSize12,
                    ),
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
              ],
            ),
          ),
        ),
      )
    );
  }
}

