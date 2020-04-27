
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/my_card.dart';

class OrderTagItem extends StatelessWidget {

  const OrderTagItem({
    Key key,
    @required this.date,
    @required this.orderTotal,
  }) : super(key: key);
  
  final String date;
  final int orderTotal;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
        child: Container(
          height: 34.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: <Widget>[
              ThemeUtils.isDark(context) ? const LoadAssetImage('order/icon_calendar_dark', width: 14.0, height: 14.0) :
              const LoadAssetImage('order/icon_calendar', width: 14.0, height: 14.0),
              Gaps.hGap10,
              Text(date),
              Expanded(child: Gaps.empty),
              Text('$orderTotal单')
            ],
          ),
        )
      ),
    );
  }
}