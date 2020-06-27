
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/presenter/market_presenter.dart';
import 'package:fjut_qcx/market/widget/resumes_item.dart';
import 'package:fjut_qcx/mvp/base_page_state.dart';
import 'package:fjut_qcx/mvp/base_page_list_view.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:fjut_qcx/res/gaps.dart';
import 'package:flutter/material.dart';

class ResumesList extends StatefulWidget {
  
  const ResumesList({
    Key key,
  }): super(key: key);


  @override
  ResumesListState createState() => ResumesListState();
}

class ResumesListState extends BasePageState<ResumesList, ResumesPresenter> with AutomaticKeepAliveClientMixin<ResumesList>, SingleTickerProviderStateMixin{


  BaseListProvider<ResumeModel> provider = BaseListProvider();

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
    presenter.getResumes(
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
          return ResumesItem(
            key: Key('ResumesItem_$index'),
            model:provider.list[index],
          );
        }
    );
  }

  @override
  ResumesPresenter createPresenter() => new ResumesPresenter();

  @override
  bool get wantKeepAlive => true;

}
