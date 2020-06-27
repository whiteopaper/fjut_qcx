

import 'package:fjut_qcx/market/model/work_model.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/market/widget/works_item.dart';
import 'package:fjut_qcx/mvp/base_page_list_view.dart';
import 'package:fjut_qcx/mvp/base_page_state.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:fjut_qcx/widgets/search_bar.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WorkSearchPage extends StatefulWidget {

  const WorkSearchPage({Key key,}) : super(key: key);

  @override
  WorkSearchPageState createState() => WorkSearchPageState();
}

class WorkSearchPageState extends BasePageState<WorkSearchPage, WorkSearchPresenter> {

  BaseListProvider<WorkModel> provider = BaseListProvider<WorkModel>();
  
  String _keyword;
  
  @override
  void initState() {
    /// 默认为加载中状态，本页面场景默认为空
    provider.setStateTypeNotNotify(StateType.empty);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<WorkModel>>(
      create: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: '请输入岗位查询',
          onPressed: (text) {
            if (text.isEmpty) {
              showToast('搜索关键字不能为空！');
              return;
            }
            FocusScope.of(context).unfocus();
            _keyword = text;
            provider.setStateType(StateType.loading);
            _onRefresh();
          },
        ),
        body: Consumer<BaseListProvider<WorkModel>>(
          builder: (_, provider, __) {
            return BaseListView(
              key: Key('market_search_list'),
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
              },
            );
          }
        ),
      ),
    );
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
        _keyword, false ,
        onBackCall: (){
          setState(() {

          });
        }
    );
  }

  @override
  WorkSearchPresenter createPresenter() => WorkSearchPresenter();
}
