
import 'package:dio/dio.dart';
import 'package:fjut_qcx/article/models/article_model.dart';
import 'package:fjut_qcx/article/view/articles_list_page.dart';
import 'package:fjut_qcx/mvp/base_page_presenter.dart';
import 'package:fjut_qcx/net/dio_qcx.dart';
import 'package:fjut_qcx/net/error_handle.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/cupertino.dart';


class ArticlesPresenter extends BasePagePresenter<ArticlesListPageState> {

  BaseListProvider<ArticleModel> provider = BaseListProvider<ArticleModel>();

  Future getArticle( int typeId, bool isShowDialog,{Function onSuccess}) {
    provider.toggle();
    Map<String, int> params = Map();
    params['page'] = provider.page;
    params['typeid'] = typeId;
    params['type'] = 3;
    return request<ArticleModel>(Method.post,
      url: HttpApi.getArticle,
      params: params,
      isShow: isShowDialog,
      onSuccessListT: (data) {
        if (data != null) {
          /// 一页10条数据，等于10条认为有下一页
          provider.setHasMore(data.length == 10);
          if (provider.page == 1) {
            /// 刷新
            provider.list.clear();
            if (data.isEmpty) {
              provider.setStateType(StateType.empty);
            } else {
              provider.addAll(data);
            }
          } else {
            provider.addAll(data);
          }
          provider.toggle();
          if(onSuccess()!=null){
            onSuccess();
          }
        } else {
          /// 加载失败
          provider.setHasMore(false);
          provider.setStateType(StateType.network);
        }
      },
      onError: (_, __) {
        /// 加载失败
        provider.setHasMore(false);
        provider.setStateType(StateType.network);
      }
    );
  }


  /// 返回Future 适用于刷新，加载更多
  Future request<T>(Method method, {@required String url, bool isShow : true, bool isClose: true, Function(T t) onSuccess,
    Function(List list) onSuccessList,Function(List<T> list) onSuccessListT, Function(int code, String msg) onError, dynamic params,
    Map<String, dynamic> queryParameters, CancelToken cancelToken, Options options, bool isList : true}) {
    if (isShow) view.showProgress();
    return DioUtils.instance.requestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        isList: isList,
        onSuccess: (data) {
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onSuccessList: (data) {
          if (isClose) view.closeProgress();
          if (onSuccessList != null) {
            onSuccessList(data);
          }
        },
        onSuccessListT: (data) {
          if (isClose) view.closeProgress();
          if (onSuccessListT != null) {
            onSuccessListT(data);
          }
        },
        onError: (code, msg) {
          _onError(code, msg, onError);
        }
    );
  }

  _onError(int code, String msg, Function(int code, String msg) onError) {
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }
    /// 页面如果dispose，则不回调onError
    if (onError != null && view.getContext() != null) {
      onError(code, msg);
    }
  }
}