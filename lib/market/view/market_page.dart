
import 'package:fjut_qcx/common/common.dart';
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:fjut_qcx/market/market_router.dart';
import 'package:fjut_qcx/market/provider/market_page_provider.dart';
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/popup_window.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:provider/provider.dart';

import 'market_list_page.dart';


class MarketPage extends StatefulWidget {
  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>  with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{

  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);

  MarketPageProvider provider = MarketPageProvider();
  LoginPresenter presenter = LoginPresenter();

  GlobalKey _addKey = GlobalKey();
  bool hasProve = false;
  bool isStudent = false;
  bool isCompany = false;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    presenter.info(
        onSuccessMap: (data){
          setState(() {
            UserModel currentUser = UserModel.fromJson(data);
            hasProve = (currentUser.state==1);
          });
        }
    );
    presenter.isRole(
      Constant.studentRid,
      onSuccess: (data){
        setState(() {
          isStudent = true;
        });
      },
    );
    presenter.isRole(
      Constant.companyRid,
      onSuccess: (data){
        setState(() {
          isCompany = true;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  hasProve?ChangeNotifierProvider<MarketPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              tooltip: '搜索',
              onPressed: () {
                isStudent?NavigatorUtils.push(context, MarketRouter.workSearchPage):null;
                isCompany?NavigatorUtils.push(context, MarketRouter.resumeSearchPage):null;
              },
              icon: LoadAssetImage(
                'goods/search',
                key: const Key('search'),
                width: 24.0,
                height: 24.0,
//                color: _iconColor,
              ),
            ),
            IconButton(
              tooltip: '添加',
              key: _addKey,
              onPressed: () {
                _showAddMenu();
              },
              icon: LoadAssetImage(
                'market/more',
                key: const Key('more'),
                width: 24.0,
                height: 24.0,
              ),
            )
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
                  const _TabView('简历市场', 0),
                  const _TabView('工作市场', 1),
                ],
              ),
            ),
            Gaps.line,
            //List
            Expanded(
              child: PageView.builder(
                  key: const Key('pageView'),
                  itemCount: 2,
                  onPageChanged: _onPageChange,
                  controller: _pageController,
                  itemBuilder: (_, int index) =>MarketListPage(
                    index: index,
                    isStudent: isStudent,
                    isCompany: isCompany,
                  )
              ),
            )
          ],
        ),
      ),
    ):StateLayout(type: StateType.noPermission);
  }

  _onPageChange(int index) {
    _tabController.animateTo(index);
    provider.setIndex(index);
  }


  @override
  bool get wantKeepAlive => true;

  _showAddMenu() {
    final RenderBox button = _addKey.currentContext.findRenderObject();
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    var a =  button.localToGlobal(Offset(button.size.width - 8.0, button.size.height - 12.0), ancestor: overlay);
    var b =  button.localToGlobal(button.size.bottomLeft(Offset(0, - 12.0)), ancestor: overlay);
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(a, b),
      Offset.zero & overlay.size,
    );
    final Color backgroundColor = ThemeUtils.getBackgroundColor(context);
    final Color _iconColor = ThemeUtils.getIconColor(context);
    showPopupWindow(
      context: context,
      fullWidth: false,
      isShowBg: true,
      position: position,
      elevation: 0.0,
      child: GestureDetector(
        onTap: () => NavigatorUtils.goBack(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: LoadAssetImage('goods/jt', width: 8.0, height: 4.0,
                color: ThemeUtils.getDarkColor(context, Colours.dark_bg_color),
              ),
            ),
            isStudent?SizedBox(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                  textColor: Theme.of(context).textTheme.body1.color,
                  onPressed: () {
                    NavigatorUtils.push(context, '${MarketRouter.resumeDetailPage}?isAdd=true',replace: true);
                  },
                  color: backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                  ),
                  icon: LoadAssetImage('market/edit', width: 16.0, height: 16.0, color: _iconColor,),
                  label: const Text('个人简历')
              ),
            ):Gaps.empty,
            isCompany?Container(width: 120.0, height: 0.6, color: Colours.line):Gaps.empty,
            isCompany?SizedBox(
              width: 120.0,
              height: 40.0,
              child: FlatButton.icon(
                  textColor: Theme.of(context).textTheme.body1.color,
                  color: backgroundColor,
                  onPressed: () {
                    NavigatorUtils.push(context, '${MarketRouter.workDetailPage}?isAdd=true',replace: true);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                  ),
                  icon: LoadAssetImage('market/edit', width: 16.0, height: 16.0, color: _iconColor,),
                  label: const Text('企业工作')
              ),
            ):Gaps.empty,
          ],
        ),
      ),
    );
  }
}

class _TabView extends StatelessWidget {

  const _TabView(this.tabName, this.index);

  final String tabName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketPageProvider>(
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


