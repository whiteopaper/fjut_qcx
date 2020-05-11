
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/net/net.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:flutter/cupertino.dart';

class MinePresenter {

  query( {Function(Map<String, dynamic>) onSuccessMap,Function(int code, String msg) onError}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.post, HttpApi.resumeQuery,
        isMap: true,
        onSuccessMap: onSuccessMap,
        onError: onError
    );
  }


  void asyncRequestNetwork<T>(Method method, String url,{@required Function(T t) onSuccess, Function(int code, String msg) onError,
    dynamic params, Map<String, dynamic> queryParameters,}) {
    DioUtils.instance.asyncRequestNetwork<T>(method, url,
        params: params,
        queryParameters: queryParameters,
        onSuccess: (data) {
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onError: (code, msg) {
          Toast.show(msg);
          if (onError != null) {
            onError(code, msg);
          }
        }
    );
  }
}