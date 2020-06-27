
import 'package:dio/dio.dart';
import 'package:fjut_qcx/market/model/resume_model.dart';
import 'package:fjut_qcx/market/model/work_model.dart';
import 'package:fjut_qcx/market/view/resume_search_page.dart';
import 'package:fjut_qcx/market/view/work_search_page.dart';
import 'package:fjut_qcx/market/widget/resumes_list.dart';
import 'package:fjut_qcx/market/widget/works_list.dart';
import 'package:fjut_qcx/mvp/base_page_presenter.dart';
import 'package:fjut_qcx/net/dio_utils.dart';
import 'package:fjut_qcx/net/error_handle.dart';
import 'package:fjut_qcx/net/http_api.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/cupertino.dart';


class ResumesPresenter extends BasePagePresenter<ResumesListState> {

  Future getResumes(  bool isShowDialog,{Function onBackCall}) {
    view.provider.toggle();
    Map<String, String> params = Map();
    params['page'] = view.provider.page.toString();
    return request<ResumeModel>(Method.post,
        url: HttpApi.getResumes,
        isShow: isShowDialog,
        params: params,
        onSuccessListT: (data) {
          if (data != null&&data.length!=0) {
            /// 一页10条数据，等于10条认为有下一页
            view.provider.setHasMore(data.length == 10);
            if (view.provider.page == 1) {
              /// 刷新
              view.provider.list.clear();
              if (data.isEmpty) {
                view.provider.setStateType(StateType.empty);
              } else {
                view.provider.addAll(data);
              }
            } else {
              view.provider.addAll(data);
            }
            view.provider.toggle();
          } else {
            /// 加载失败
            view.provider.toggle();
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.network);
          }
          if(onBackCall()!=null){
            onBackCall();
          }
        },
        onError: (_, __) {
          /// 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.empty);
        }
    );
  }

  query( String uid,{Function(Map<String, dynamic>) onSuccessMap,Function(int code, String msg) onError}){
    Map<String, dynamic> params = Map();
    params["user_id"] = uid;
    DioUtils.instance.asyncRequestNetwork<ResumeModel>(
        Method.post, HttpApi.resumeQuery,
        params: params,
        isMap: true,
        onSuccessMap: onSuccessMap,
        onError: onError
    );
  }

  add(Map<String, dynamic> params, bool isAdd ,{Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, isAdd?HttpApi.resumeAdd:HttpApi.resumeUpdate,
        params:params,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  delete( {Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.resumeDelete,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  collection(String id, {Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    Map<String, dynamic> params = Map();
    params["id"] = id;
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.resumeCollection,
        params: params,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  cancel(String id, {Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    Map<String, dynamic> params = Map();
    params["id"] = id;
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.resumeCancel,
        params: params,
        onSuccess: onSuccess,
        onError: onError
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

class WorksPresenter extends BasePagePresenter<WorksListState> {

  Future getWorks(  bool isShowDialog,{Function onBackCall}) {
    view.provider.toggle();
    Map<String, String> params = Map();
    params['page'] = view.provider.page.toString();
    return request<WorkModel>(Method.post,
        url: HttpApi.getWorks,
        isShow: isShowDialog,
        params: params,
        onSuccessListT: (data) {
          if (data != null&&data.length!=0) {
            /// 一页10条数据，等于10条认为有下一页
            view.provider.setHasMore(data.length == 10);
            if (view.provider.page == 1) {
              /// 刷新
              view.provider.list.clear();
              if (data.isEmpty) {
                view.provider.setStateType(StateType.empty);
              } else {
                view.provider.addAll(data);
              }
            } else {
              view.provider.addAll(data);
            }
            view.provider.toggle();
          } else {
            /// 加载失败
            view.provider.toggle();
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.network);
          }
          if(onBackCall()!=null){
            onBackCall();
          }
        },
        onError: (_, __) {
          /// 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.network);
        }
    );
  }

  query( String uid,{Function(Map<String, dynamic>) onSuccessMap,Function(int code, String msg) onError}){
    Map<String, dynamic> params = Map();
    params["user_id"] = uid;
    DioUtils.instance.asyncRequestNetwork<WorkModel>(
        Method.post, HttpApi.workQuery,
        params: params,
        isMap: true,
        onSuccessMap: onSuccessMap,
        onError: onError
    );
  }

  add(Map<String, dynamic> params, bool isAdd ,{Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, isAdd?HttpApi.workAdd:HttpApi.workUpdate,
        params:params,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  delete( {Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.workDelete,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  collection(String id, {Function(dynamic) onSuccess,Function(int code, String msg) onError}){
    Map<String, dynamic> params = Map();
    params["id"] = id;
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.workCollection,
        params: params,
        onSuccess: onSuccess,
        onError: onError
    );
  }

  cancel(String id, {Function(dynamic) onSuccess,Function(int code, String msg) onError}) {
    Map<String, dynamic> params = Map();
    params["id"] = id;
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.workCancel,
        params: params,
        onSuccess: onSuccess,
        onError: onError
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

class ResumeSearchPresenter extends BasePagePresenter<ResumeSearchPageState> {

  Future getResumes(  String text, bool isShowDialog,{Function onBackCall}) {
    view.provider.toggle();
    Map<String, String> params = Map();
    params['page'] = view.provider.page.toString();
    params['intention_position'] = text;
    return request<ResumeModel>(Method.post,
        url: HttpApi.getResumes,
        isShow: isShowDialog,
        params: params,
        onSuccessListT: (data) {
          if (data != null&&data.length!=0) {
            /// 一页10条数据，等于10条认为有下一页
            view.provider.setHasMore(data.length == 10);
            if (view.provider.page == 1) {
              /// 刷新
              view.provider.list.clear();
              if (data.isEmpty) {
                view.provider.setStateType(StateType.empty);
              } else {
                view.provider.addAll(data);
              }
            } else {
              view.provider.addAll(data);
            }
            view.provider.toggle();
          } else {
            /// 加载失败
            view.provider.toggle();
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.network);
          }
          if(onBackCall()!=null){
            onBackCall();
          }
        },
        onError: (_, __) {
          /// 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.empty);
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

class WorkSearchPresenter extends BasePagePresenter<WorkSearchPageState> {

  Future getWorks(  String text,bool isShowDialog,{Function onBackCall}) {
    view.provider.toggle();
    Map<String, String> params = Map();
    params['page'] = view.provider.page.toString();
    params['position'] = text;
    return request<WorkModel>(Method.post,
        url: HttpApi.getWorks,
        isShow: isShowDialog,
        params: params,
        onSuccessListT: (data) {
          if (data != null&&data.length!=0) {
            /// 一页10条数据，等于10条认为有下一页
            view.provider.setHasMore(data.length == 10);
            if (view.provider.page == 1) {
              /// 刷新
              view.provider.list.clear();
              if (data.isEmpty) {
                view.provider.setStateType(StateType.empty);
              } else {
                view.provider.addAll(data);
              }
            } else {
              view.provider.addAll(data);
            }
            view.provider.toggle();
          } else {
            /// 加载失败
            view.provider.toggle();
            view.provider.setHasMore(false);
            view.provider.setStateType(StateType.network);
          }
          if(onBackCall()!=null){
            onBackCall();
          }
        },
        onError: (_, __) {
          /// 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.network);
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