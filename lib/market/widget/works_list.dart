
import 'package:fjut_qcx/market/model/work_model.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/market/widget/works_item.dart';
import 'package:fjut_qcx/mvp/base_page_state.dart';
import 'package:fjut_qcx/mvp/base_page_list_view.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:flutter/material.dart';

class WorksList extends StatefulWidget {
  
  const WorksList({
    Key key,
  }): super(key: key);

  @override
  WorksListState createState() => WorksListState();
}

class WorksListState extends BasePageState<WorksList, WorksPresenter> with AutomaticKeepAliveClientMixin<WorksList>, SingleTickerProviderStateMixin{


  BaseListProvider<WorkModel> provider = BaseListProvider<WorkModel>();

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
    provider.increase();
    getData();
  }

  void getData(){
    presenter.getWorks(
        false,
        onBackCall: (){
          setState(() {
          });
        }
    );
  }

  
  @override
  Widget build(BuildContext context) {
    return BaseListView(
        itemCount: provider.list.length,
        stateType: provider.stateType,
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        hasMore: provider.hasMore,
        itemBuilder: (_, index) {
          return WorksItem(
            key: Key('WorksItem_$index'),
            model: provider.list[index],
          );
        }
    );
  }

  @override
  WorksPresenter createPresenter() => new WorksPresenter();

  @override
  bool get wantKeepAlive => true;

}
