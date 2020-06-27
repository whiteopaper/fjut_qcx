
import 'package:flutter/material.dart';
import 'package:fjut_qcx/article/view/articles_list_page.dart';
import 'package:fjut_qcx/article/provider/articles_page_provider.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:provider/provider.dart';


class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  ArticlesPageProvider provider = ArticlesPageProvider();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<ArticlesPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Gaps.empty
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //TabBar
            Container(
              padding: EdgeInsets.only(left: 16.0),
              color: ThemeUtils.getBackgroundColor(context),
              child: TabBar(
                onTap: (index) {
                  if (!mounted) {
                    return;
                  }
                  _pageController.jumpToPage(index);
                },
                isScrollable: true,
                controller: _tabController,
                labelStyle: TextStyles.textBold18,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.only(left: 0.0),
                unselectedLabelColor: ThemeUtils.isDark(context) ? Colors.lime : Colors.grey,
                labelColor: Theme.of(context).primaryColor,
                indicatorPadding: const EdgeInsets.only(right: 98.0 - 36.0),
                tabs: <Widget>[
                  const _TabView('就业指南', 0),
                  const _TabView('生涯规划', 1),
                  const _TabView('职业辅导', 2),
                  const _TabView('办理须知', 3),
                ],
              ),
            ),
            Gaps.line,
            //List
            Expanded(
              child: PageView.builder(
                key: const Key('pageView'),
                itemCount: 4,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, int index) => ArticlesListPage(index: index)
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPageChange(int index) {
    _tabController.animateTo(index);
    provider.setIndex(index);
  }


  @override
  bool get wantKeepAlive => true;
}

class _TabView extends StatelessWidget {
  
  const _TabView(this.tabName, this.index);
  
  final String tabName;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticlesPageProvider>(
      builder: (_, provider, child) {
        return Tab(
          child: SizedBox(
            width: 98.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(tabName ),
                Offstage(
                  offstage: provider.goodsCountList[index] == 0 || provider.index != index,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Text(' (${provider.goodsCountList[index]})', style: TextStyle(fontSize: Dimens.font_sp12)),
                  )
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
