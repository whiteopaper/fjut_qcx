
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/market/widget/resumes_item.dart';
import 'package:fjut_qcx/mvp/base_page_state.dart';
import 'package:fjut_qcx/mvp/base_page_list_view.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:fjut_qcx/res/gaps.dart';
import 'package:flutter/material.dart';

class MarketListPage<T> extends StatefulWidget {
  
  const MarketListPage({
    Key key,
    this.isStudent,
  }): super(key: key);

  final bool isStudent;

  @override
  MarketListPageState<T> createState() => MarketListPageState<T>();
}

class MarketListPageState<T> extends BasePageState<MarketListPage, MarketPresenter<T>> with AutomaticKeepAliveClientMixin<MarketListPage>, SingleTickerProviderStateMixin{


  List<T> _list = [];
  BaseListProvider<T> provider = BaseListProvider<T>();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    presenter.getResumes(
      false,
      onBackCall: (){
        setState(() {
          provider = presenter.provider;
          _list = provider.list;
        });
      }
    );

  }

  
  @override
  Widget build(BuildContext context) {
    return BaseListView(
      itemCount: _list.length,
      stateType: provider.stateType,
      onRefresh: _onRefresh,
      loadMore: _loadMore,
      hasMore: provider.hasMore,
      itemBuilder: (_, index) {
        return _list.length!=0?(widget.isStudent ?ResumesItem(
          key: Key('WorksItem_$index'),
          model: _list[index] as ResumeModel,
        ):ResumesItem(
          key: Key('ResumesItem_$index'),
          model: _list[index] as ResumeModel,
        )):Gaps.empty;
      }
    );
  }

  @override
  MarketPresenter<T> createPresenter() => new MarketPresenter<T>();

  @override
  bool get wantKeepAlive => true;

}
