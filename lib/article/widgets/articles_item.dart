
import 'package:fjut_qcx/article/models/article_model.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/my_card.dart';


class ArticlesItem extends StatelessWidget {

  const ArticlesItem({
    Key key,
    @required this.model,
  }) : super(key: key);

  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);

    return Container(
      child: _container(context),
    );
  }

  Widget _container(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: MyCard(
          child: Container(
            child: InkWell(
              onTap: () =>
                  NavigatorUtils.goWebViewPage(
                      context,
                      model.title,
                      HttpApi.getArticleDetail + model.id
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          model.title,
                          style: TextStyle(
                            fontSize: Dimens.font_sp18,
                            color: Colours.text,
                          ),
                        ),
                        Text(
                          model.senddate,
                          style: TextStyle(
                            fontSize: Dimens.font_sp14,
                            color: Colours.text_gray_c,
                          ),
                        ),
                        Gaps.vGap5,
                        Container(
                          height: Dimens.gap_dp50,
                          child: Text(
                            "概述:"+model.content.trim(),
                            style: TextStyle(
                              fontSize: Dimens.font_sp16,
                              color: Colours.text_gray,
                            ),
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