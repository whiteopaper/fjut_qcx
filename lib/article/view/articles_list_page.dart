

import 'package:fjut_qcx/article/models/article_model.dart';
import 'package:fjut_qcx/article/presenter/articles_presenter.dart';
import 'package:fjut_qcx/article/widgets/articles_item.dart';
import 'package:fjut_qcx/mvp/base_page_state.dart';
import 'package:fjut_qcx/mvp/base_page_list_view.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:fjut_qcx/article/provider/articles_page_provider.dart';
import 'package:provider/provider.dart';

class ArticlesListPage extends StatefulWidget {
  
  const ArticlesListPage({
    Key key,
    @required this.index
  }): super(key: key);
  
  final int index;
  
  @override
  ArticlesListPageState createState() => ArticlesListPageState();
}

class ArticlesListPageState extends BasePageState<ArticlesListPage, ArticlesPresenter> with AutomaticKeepAliveClientMixin<ArticlesListPage>, SingleTickerProviderStateMixin {

  List<ArticleModel> _list = [];
  BaseListProvider<ArticleModel> provider = BaseListProvider<ArticleModel>();

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
    int typeId = 26;
    if (widget.index==0){
      typeId = 26;
    } else if (widget.index==1){
      typeId = 23;
    } else if (widget.index==2){
      typeId = 22;
    } else if (widget.index==3){
      typeId = 38;
    }
    presenter.getArticle(
        typeId,
        false,
        onSuccess: (){
          setState(() {
            provider = presenter.provider;
            _list = provider.list;
            _setGoodsCount(_list.length);
          });
        }
    );

  }
  
  _setGoodsCount(int count) {
    ArticlesPageProvider provider = Provider.of<ArticlesPageProvider>(context, listen: false);
    provider.setGoodsCount(count);
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseListView(
      itemCount: _list.length,
      stateType: provider.stateType,
      onRefresh: _onRefresh,
      loadMore: _loadMore,
      hasMore: provider.hasMore,
      itemBuilder: (_, index) {
        return ArticlesItem(
          model: _list[index],
        );
      }
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  ArticlesPresenter createPresenter() => new ArticlesPresenter();

}
