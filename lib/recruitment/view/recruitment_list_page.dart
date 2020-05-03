
import 'package:fjut_qcx/mvp/base_page_state.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/recruitment/models/job_fair_model.dart';
import 'package:fjut_qcx/recruitment/models/keynote_model.dart';
import 'package:fjut_qcx/recruitment/models/recruitment_brochure_model.dart';
import 'package:fjut_qcx/recruitment/presenter/recruitment_presenter.dart';
import 'package:fjut_qcx/recruitment/provider/recruitment_page_provider.dart';
import 'package:fjut_qcx/recruitment/widgets/recruitment_item.dart';
import 'package:fjut_qcx/widgets/base_page_list_view.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:provider/provider.dart';


class RecruitmentListPage extends StatefulWidget {

  const RecruitmentListPage({
    Key key,
    @required this.index,
  }): super(key: key);

  final int index;

  @override
  RecruitmentListPageState createState() => RecruitmentListPageState();
}

class RecruitmentListPageState extends BasePageState<RecruitmentListPage, RecruitmentPresenter> with AutomaticKeepAliveClientMixin<RecruitmentListPage> {


  int _index = 0;
  ScrollController _controller = ScrollController();
  BaseListProvider provider = BaseListProvider();
  BaseListProvider<Job_fair_model> providerJ = BaseListProvider<Job_fair_model>();
  BaseListProvider<Keynote_model> providerK = BaseListProvider<Keynote_model>();
  BaseListProvider<Recruitment_brochure_model> providerR = BaseListProvider<Recruitment_brochure_model>();


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
        child: Consumer<RecruitmentPageProvider>(
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
            sliver: _list.isEmpty ? SliverFillRemaining(child: StateLayout(type: provider.stateType)) :
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                if(index < _list.length) {
                  model['$_index+$index']=_list[index];
                }
                return index < _list.length ?
                    ( RecruitmentItem(key: Key('recruitment_item_$index'),  tabIndex:_index , index: index, model: model))
                    : MoreWidget(_list.length, provider.hasMore);
              },
              childCount: _list.length + 1),
            ),
          ),
        ),
      ),
    );
  }

  List _list = [];
  Map<String,dynamic> model = Map();

  Future _onRefresh() async {
    provider.refresh();
    getData();
  }


  Future _loadMore() async {
    if (provider.isLoading) {
      return;
    }
    if (!provider.hasMore) {
      return;
    }
    getData();
  }

  void getData(){
    if(_index == 0 ){
      presenter.getJobFair(
          false,
          onSuccess: (){
            setState(() {
              _list = providerJ.list;
            });
          }
      );
      provider = providerJ;
    } else if(_index == 1 ){
      presenter.getKeynote(
          false,
          onSuccess: (){
            setState(() {
              _list = providerK.list;
            });
          }
      );
      provider = providerK;
    } else if(_index == 2 ){
      presenter.getRecruitmentBrochure(
          false,
          onSuccess: (){
            setState(() {
              _list = providerR.list;
            });
          }
      );
      provider = providerR;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  RecruitmentPresenter createPresenter() => new RecruitmentPresenter();
}
