
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fjut_qcx/mvp/base_page_presenter.dart';
import 'package:fjut_qcx/net/dio_qcx.dart';
import 'package:fjut_qcx/net/error_handle.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:fjut_qcx/recruitment/models/job_fair_model.dart';
import 'package:fjut_qcx/recruitment/models/keynote_model.dart';
import 'package:fjut_qcx/recruitment/models/recruitment_brochure_model.dart';
import 'package:fjut_qcx/recruitment/view/recruitment_list_page.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/cupertino.dart';


class RecruitmentPresenter extends BasePagePresenter<RecruitmentListPageState> {

  Future getJobFair( bool isShowDialog,{Function onSuccess}) {
    view.providerJ.toggle();
    Map<String, int> params = Map();
    params['page'] = view.providerJ.page;
    return request<Job_fair_model>(Method.post,
      url: HttpApi.jobfairList,
      params: params,
      isShow: isShowDialog,
      onSuccessListT: (data) {
        if (data != null) {
          /// 一页10条数据，等于10条认为有下一页
          view.providerJ.setHasMore(data.length == 10);
          if (view.providerJ.page == 1) {
            /// 刷新
            view.providerJ.list.clear();
            if (data.isEmpty) {
              view.providerJ.setStateType(StateType.empty);
            } else {
              view.providerJ.addAll(data);
            }
          } else {
            view.providerJ.addAll(data);
          }
          view.providerJ.increase();
          view.providerJ.toggle();
          if(onSuccess()!=null){
            onSuccess();
          }
        } else {
          /// 加载失败
          view.providerJ.setHasMore(false);
          view.providerJ.setStateType(StateType.network);
        }
      },
      onError: (_, __) {
        /// 加载失败
        view.providerJ.setHasMore(false);
        view.providerJ.setStateType(StateType.network);
      }
    );
  }

  Future getKeynote( bool isShowDialog,{Function onSuccess}) {
    view.providerK.toggle();
    Map<String, int> params = Map();
    params['page'] = view.providerK.page;
    return request<Keynote_model>(Method.post,
        url: HttpApi.keynoteList,
        params: params,
        isShow: isShowDialog,
        onSuccessListT: (data) {
          if (data != null) {
            /// 一页10条数据，等于10条认为有下一页
            view.providerK.setHasMore(data.length == 10);
            if (view.providerK.page == 1) {
              /// 刷新
              view.providerK.list.clear();
              if (data.isEmpty) {
                view.providerK.setStateType(StateType.empty);
              } else {
                view.providerK.addAll(data);
              }
            } else {
              view.providerK.addAll(data);
            }
            view.providerK.increase();
            view.providerK.toggle();
            if(onSuccess()!=null){
              onSuccess();
            }
          } else {
            /// 加载失败
            view.providerK.setHasMore(false);
            view.providerK.setStateType(StateType.network);
          }
        },
        onError: (_, __) {
          /// 加载失败
          view.providerK.setHasMore(false);
          view.providerK.setStateType(StateType.network);
        }
    );
  }

  Future getRecruitmentBrochure( bool isShowDialog,{Function onSuccess}) {
    view.providerR.toggle();
    Map<String, int> params = Map();
    params['page'] = view.providerR.page;
    return request<Recruitment_brochure_model>(Method.post,
        url: HttpApi.recruitmentBrochureList,
        params: params,
        isShow: isShowDialog,
        onSuccessListT: (data) {
          if (data != null) {
            /// 一页10条数据，等于10条认为有下一页
            view.providerR.setHasMore(data.length == 10);
            if (view.providerR.page == 1) {
              /// 刷新
              view.providerR.list.clear();
              if (data.isEmpty) {
                view.providerR.setStateType(StateType.empty);
              } else {
                view.providerR.addAll(data);
              }
            } else {
              view.providerR.addAll(data);
            }
            view.providerR.increase();
            view.providerR.toggle();
            if(onSuccess()!=null){
              onSuccess();
            }
          } else {
            /// 加载失败
            view.providerR.setHasMore(false);
            view.providerR.setStateType(StateType.network);
          }
        },
        onError: (_, __) {
          /// 加载失败
          view.providerR.setHasMore(false);
          view.providerR.setStateType(StateType.network);
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