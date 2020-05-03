
import 'package:flutter/material.dart';
import 'package:fjut_qcx/login/provider/deptment_provider.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:provider/provider.dart';


/// design/4商品/index.html#artboard20
class DepartmentSortDialog extends StatefulWidget {

  const DepartmentSortDialog({
    Key key,
    @required this.provider,
    @required this.onSelected,
  }): super(key: key);

  final Function(int, String) onSelected;
  /// 临时状态
  final DepartmentSortProvider provider;
  
  @override
  DepartmentSortDialogState createState() => DepartmentSortDialogState();
}

class DepartmentSortDialogState extends State<DepartmentSortDialog> with SingleTickerProviderStateMixin {
  
  TabController _tabController;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.provider.initData();
      _tabController.animateTo(widget.provider.index, duration: const Duration(microseconds: 0));
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 11.0 / 16.0,
        /// 为保留状态，选择ChangeNotifierProvider.value，销毁自己手动处理（见 goods_edit_page.dart ：dispose()）
        child: ChangeNotifierProvider<DepartmentSortProvider>.value(
          value: widget.provider,
          child: Consumer<DepartmentSortProvider>(
            builder: (_, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  child,
                  Gaps.line,
                  Container(
                    // 隐藏点击效果
                    color: ThemeUtils.getDialogBackgroundColor(context),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      onTap: (index) {
                        if (provider.myTabs[index].text.isEmpty) {
                          // 拦截点击事件
                          _tabController.animateTo(provider.index);
                          return;
                        }
                        provider.setList(index);
                        provider.setIndex(index);
                        _controller.animateTo(provider.positions[provider.index] * 48.0, duration: Duration(milliseconds: 10), curve: Curves.ease);
                      },
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: ThemeUtils.isDark(context) ? Colours.text_gray : Colours.text,
                      labelColor: Theme.of(context).primaryColor,
                      tabs: provider.myTabs,
                    ),
                  ),
                  Gaps.line,
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemExtent: 48.0,
                      itemBuilder: (_, index) {
                        bool flag = provider.mList[index]['name'] == provider.myTabs[provider.index].text;
                        return InkWell(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Text(
                                    provider.mList[index]['name'],
                                    style: flag ? TextStyle(
                                      fontSize: Dimens.font_sp14,
                                      color: Theme.of(context).primaryColor,
                                    ) : null),
                                Gaps.hGap8,
                                Visibility(
                                  visible: flag,
                                  child: const LoadAssetImage('goods/xz', height: 16.0, width: 16.0),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            provider.myTabs[provider.index] = Tab(text: provider.mList[index]['name']);
                            provider.positions[provider.index] = index;

                            provider.indexIncrement();
                            provider.setListAndChangeTab();
                            if (provider.index > 2) {
                              provider.setIndex(2);
                              widget.onSelected(provider.mList[index]['id'], provider.deptName);
                              NavigatorUtils.goBack(context);
                            }
                            _controller.animateTo(0.0, duration: Duration(milliseconds: 100), curve: Curves.ease);
                            _tabController.animateTo(provider.index);
                          },
                        );
                      },
                      itemCount: provider.mList.length,
                    ),
                  )
                ],
              );
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: const Text(
                    '商品分类',
                    style: TextStyles.textBold16,
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: () => NavigatorUtils.goBack(context),
                    child: const SizedBox(
                        height: 16.0,
                        width: 16.0,
                        child: const LoadAssetImage('goods/icon_dialog_close')
                    ),
                  ),
                  right: 16.0,
                  top: 16.0,
                  bottom: 16.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
