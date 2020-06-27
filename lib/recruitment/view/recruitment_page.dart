

import 'package:flutter/material.dart';
import 'package:fjut_qcx/recruitment/view/recruitment_list_page.dart';
import 'package:fjut_qcx/recruitment/provider/recruitment_page_provider.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/image_utils.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:fjut_qcx/widgets/my_card.dart';
import 'package:fjut_qcx/widgets/my_flexible_space_bar.dart';
import 'package:provider/provider.dart';

import '../recruitment_router.dart';


class RecruitmentPage extends StatefulWidget {
  @override
  _RecruitmentPageState createState() => _RecruitmentPageState();
}

class _RecruitmentPageState extends State<RecruitmentPage> with AutomaticKeepAliveClientMixin<RecruitmentPage>, SingleTickerProviderStateMixin {

  @override
  bool get wantKeepAlive => true;
  
  TabController _tabController;
  RecruitmentPageProvider provider = RecruitmentPageProvider();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      /// 预先缓存剩余切换图片
      _preCacheImage();
    });
  }

  _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage('recruitment/icon_keynote'), context);
    precacheImage(ImageUtils.getAssetImage('recruitment/icon_jobFair'), context);
    precacheImage(ImageUtils.getAssetImage('recruitment/icon_regulations'), context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  bool isDark = false;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<RecruitmentPageProvider>(
      create: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            /// 像素对齐问题的临时解决方法
            SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: isDark ? null : const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: const [Color(0xFF5793FA), Color(0xFF4647FA)])
                  )
                ),
              ),
            ),
            NestedScrollView(
              key: const Key('recruitment_list'),
              physics: ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) => _sliverBuilder(context),
              body: PageView.builder(
                key: const Key('pageView'),
                itemCount: 3,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, index) => RecruitmentListPage(index: index)
              ),
            ),
          ],
      ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          brightness: Brightness.dark,
          actions: <Widget>[
//            IconButton(
//              onPressed: () {
//                NavigatorUtils.push(context, RecruitmentRouter.recruitmentPage);
//              },
//              tooltip: '搜索',
//              icon: LoadAssetImage('recruitment/icon_search',
//                width: 22.0,
//                height: 22.0,
//                color: ThemeUtils.getIconColor(context),
//              ),
//            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 200.0,
          floating: false, // 不随着滑动隐藏标题
          pinned: true, // 固定在顶部
          flexibleSpace: MyFlexibleSpaceBar(
            background: isDark ? Container(height: 113.0, color: Colours.dark_bg_color,) : LoadAssetImage('recruitment/recruitment_bg',
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              fit: BoxFit.fill,
            ),
            centerTitle: false,
            titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text('亲苍霞人才网', style: TextStyle(color: ThemeUtils.getIconColor(context)),),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? Colours.dark_bg_color : null,
                image: isDark ? null : DecorationImage(
                  image: ImageUtils.getAssetImage('recruitment/recruitment_bg1'),
                  fit: BoxFit.fill
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyCard(
                  child: Container(
                    height: 80.0,
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      controller: _tabController,
                      labelColor: ThemeUtils.isDark(context) ? Colours.dark_text : Colours.text,
                      unselectedLabelColor: ThemeUtils.isDark(context) ? Colours.dark_text_gray : Colours.text,
                      labelStyle: TextStyles.textBold14,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: Dimens.font_sp14,
                      ),
                      indicatorColor: Colors.transparent,
                      tabs: const <Widget>[
                        const _TabView(0, '招聘会'),
                        const _TabView(1, '宣讲会'),
                        const _TabView(2, '招聘简章'),
                      ],
                      onTap: (index) {
                        if (!mounted) {
                          return;
                        }
                        _pageController.jumpToPage(index);
                      },
                    ),
                  ),
                ),
              ),
            )
            , 80.0
        ),
      ),
    ];
  }

  _onPageChange(int index) async {
    provider.setIndex(index);
    _tabController.animateTo(index);
  }
}

var img = [
  ['recruitment/icon_keynote_fill', 'recruitment/icon_keynote'],
  ['recruitment/icon_jobFair_fill', 'recruitment/icon_jobFair'],
  ['recruitment/icon_regulations_fill', 'recruitment/icon_regulations'],
];

var darkImg = [
  ['recruitment/icon_keynote_fill', 'recruitment/icon_keynote'],
  ['recruitment/icon_jobFair_fill', 'recruitment/icon_jobFair'],
  ['recruitment/icon_regulations_fill', 'recruitment/icon_regulations'],
];

class _TabView extends StatelessWidget {

  const _TabView(this.index, this.text);

  final int index;
  final String text;
  
  @override
  Widget build(BuildContext context) {
    var imgList = ThemeUtils.isDark(context) ? darkImg : img;
    return Consumer<RecruitmentPageProvider>(
      builder: (_, provider, child) {
        int selectIndex = provider.index;
        return Stack(
          children: <Widget>[
            Container(
              width: 60.0,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  LoadAssetImage(selectIndex == index ? imgList[index][0] : imgList[index][1],
                    width: 24.0,
                    height: 24.0,
                    color: selectIndex == index ? Colours.unselected_icon_color:Colours.app_main,
                  ),
                  Gaps.vGap4,
                  Text(text,
                    style: TextStyle(
//                      color: Colors.blue,
                      fontSize: 14.0,
                  ),)
                ],
              ),
            ),
            child
          ],
        );
      },
      child: Positioned(
        right: 0.0,
        child:  Gaps.empty,
      )
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}