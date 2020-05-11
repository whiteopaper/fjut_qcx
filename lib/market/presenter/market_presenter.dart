
import 'package:dio/dio.dart';
import 'package:fjut_qcx/market/view/market_list_page.dart';
import 'package:fjut_qcx/mvp/base_page_presenter.dart';
import 'package:fjut_qcx/net/dio_utils.dart';
import 'package:fjut_qcx/net/error_handle.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:fjut_qcx/provider/base_list_provider.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/cupertino.dart';


class MarketPresenter<T> extends BasePagePresenter<MarketListPageState> {

  BaseListProvider<T> provider = BaseListProvider<T>();

  Future getResumes(  bool isShowDialog,{String edm, String ip,Function onBackCall}) {
    provider.toggle();
    Map<String, String> params = Map();
    if(edm!=null&&ip!=null){
      params['education_department_major'] = edm;
      params['intention_position'] = ip;
    }
    return request<T>(Method.post,
      url: HttpApi.getResumes,
      isShow: isShowDialog,
      params: params,
      onSuccessListT: (data) {
        if (data != null&&data.length!=0) {
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
          provider.increase();
          provider.toggle();
        } else {
          /// 加载失败
          provider.toggle();
          provider.setHasMore(false);
          provider.setStateType(StateType.network);
        }
        if(onBackCall()!=null){
          onBackCall();
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