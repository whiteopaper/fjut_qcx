
import 'package:fjut_qcx/article/view/articles_page.dart';
import 'package:fjut_qcx/login/page/login_page.dart';
import 'package:fjut_qcx/market/view/market_page.dart';
import 'package:fjut_qcx/mine/view/mine_page.dart';
import 'package:fjut_qcx/recruitment/view/recruitment_page.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/home/provider/home_provider.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/double_tap_back_exit_app.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _pageList;
  
  var _appBarTitles = ['首页', '推文', '求职', '我的'];
  final _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  @override
  void initState() {
    super.initState();
    initData();
  }
  
  void initData() {
    _pageList = [
      RecruitmentPage(),
      ArticlesPage(),
      MarketPage(),
      MinePage()
    ];
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      var _tabImages = [
        [
          const LoadAssetImage('home/icon_home', width: 18, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_home_fill', width: 20, color: Colours.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_news_hot', width: 18, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_news_hot_fill', width: 20, color: Colours.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_hot', width: 18, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_hot_fill', width: 20, color: Colours.app_main,),
        ],
        [
          const LoadAssetImage('home/icon_my', width: 18, color: Colours.unselected_item_color,),
          const LoadAssetImage('home/icon_my_fill', width: 20, color: Colours.app_main,),
        ]
      ];
      _list = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImages[i][0],
            activeIcon: _tabImages[i][1],
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _list;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      var _tabImagesDark = [
        [
          const LoadAssetImage('home/icon_home', width: 18),
          const LoadAssetImage('home/icon_home_fill', width: 20, color: Colours.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_news_hot', width: 18),
          const LoadAssetImage('home/icon_news_hot_fill', width: 20, color: Colours.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_hot', width: 18),
          const LoadAssetImage('home/icon_hot_fill', width: 20, color: Colours.dark_app_main,),
        ],
        [
          const LoadAssetImage('home/icon_my', width: 18),
          const LoadAssetImage('home/icon_my_fill', width: 20, color: Colours.dark_app_main,),
        ]
      ];

      _listDark = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImagesDark[i][0],
            activeIcon: _tabImagesDark[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]),),
            )
        );
      });
    }
    return _listDark;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provider, __) {
              return BottomNavigationBar(
                backgroundColor: isDark ?Colours.dark_bg_gray:Colours.bg_gray,
                items: isDark ? _buildDarkBottomNavigationBarItem() : _buildBottomNavigationBarItem(),
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 3.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp11,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark ? Colours.dark_unselected_item_color : Colours.unselected_item_color,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
          // 使用PageView的原因参看 https://zhuanlan.zhihu.com/p/58582876
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pageList,
            physics: NeverScrollableScrollPhysics(), // 禁止滑动
          )
        ),
      ),
    );
  }

  void _onPageChanged(int index) {
    provider.value = index;
  }

  @override
  void dispose() {
    super.dispose();
  }

}
