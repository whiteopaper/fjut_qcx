
import 'package:fjut_qcx/order/models/recruit_entity.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/order/provider/order_page_provider.dart';
import 'package:fjut_qcx/order/widgets/order_item.dart';
import 'package:fjut_qcx/order/widgets/order_tag_item.dart';
import 'package:fjut_qcx/widgets/my_refresh_list.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {

  const OrderListPage({
    Key key,
    @required this.index,
  }): super(key: key);

  final int index;
  
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> with AutomaticKeepAliveClientMixin<OrderListPage> {

  /// 是否正在加载数据
  bool _isLoading = false;
  int _page = 1;
  final int _maxPage = 3;
  StateType _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();
  RecruitModel _model = RecruitModel(
      '1',
      '福建省2020年住房城乡建设行业专场招聘会福建工程学院2020届毕业生供需见面会',
      'https://jiuye.fjut.edu.cn//Uploads/icon/5db8f51209a14.jpg',
      '在线招聘会',
      '2020年2月2日',
      '测试地点',
      '测试文档',
  );
  
  @override
  void initState() {
    super.initState();
    _index = widget.index;
    _onRefresh();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          _loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        displacement: 120.0, /// 默认40， 多添加的80为Header高度
        child: Consumer<OrderPageProvider>(
          builder: (_, provider, child) {
            return CustomScrollView(
              /// 这里指定controller可以与外层NestedScrollView的滚动分离，避免一处滑动，5个Tab中的列表同步滑动。
              /// 这种方法的缺点是会重新layout列表
              controller: _index != provider.index ? _controller : null,
              key: PageStorageKey<String>('$_index'),
              slivers: <Widget>[
                SliverOverlapInjector(
                  ///SliverAppBar的expandedHeight高度,避免重叠
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                child
              ],
            );
          },
          child: SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: _list.isEmpty ? SliverFillRemaining(child: StateLayout(type: _stateType)) :
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                return index < _list.length ?
                    ( OrderItem(key: Key('order_item_$index'), index: index, model: _model,))
                    : MoreWidget(_list.length, _hasMore(), 10);
              },
              childCount: _list.length + 1),
            ),
          ),
        ),
      ),
    );
  }

  List _list = [];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _page = 1;
        _list = List.generate(10, (i) => 'newItem：$i');
      });
    });
  }

  bool _hasMore() {
    return _page < _maxPage;
  }

  Future _loadMore() async {
    if (_isLoading) {
      return;
    }
    if (!_hasMore()) {
      return;
    }
    _isLoading = true;
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _list.addAll(List.generate(10, (i) => 'newItem：$i'));
        _page ++;
        _isLoading = false;
      });
    });
  }
  
  @override
  bool get wantKeepAlive => true;
}
