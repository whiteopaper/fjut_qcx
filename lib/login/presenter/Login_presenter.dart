
import 'package:fjut_qcx/mine/model/user_model.dart';
import 'package:fjut_qcx/net/net.dart';
import 'package:fjut_qcx/util/toast.dart';
import 'package:flutter/cupertino.dart';

class LoginPresenter {


  login(String username, String password, {Function(String t) onSuccess}){
    Map<String, String> params = Map();
    params['username'] = username;
    params['password'] = password;
    asyncRequestNetwork<String>(
      Method.post, HttpApi.login,
      params: params,
      onSuccess: onSuccess,
    );
  }

  register(String username, String password, String mobile, {Function(String t) onSuccess}){
    Map<String, dynamic> params = Map();
    params['name'] = username;
    params['password'] = password;
    params['mobile'] = mobile;
    asyncRequestNetwork<String>(
        Method.post, HttpApi.register,
        params: params,
        onSuccess: onSuccess
    );
  }

  registerNext(String vsername, String email, String introduction, int deptId, {Function(String t) onSuccess}){
    Map<String, dynamic> params = new Map();
    params['vserName'] = vsername;
    params['email'] = email;
    params['introduction'] = introduction;
    params['deptid'] = deptId;
    asyncRequestNetwork<String>(
        Method.post, HttpApi.modifyPersonalInfo,
        params: params,
        onSuccess: onSuccess
    );
  }


  //登录-刷新用户信息
  info( {Function(Map<String, dynamic>) onSuccessMap}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.get, HttpApi.userInfo,
        isMap: true,
        onSuccessMap: onSuccessMap
    );
  }

  //注册-获取公开部门树
  departments( {Function(List<dynamic> list) onSuccessList}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.get, HttpApi.departments,
        isList: true,
        onSuccessList: onSuccessList
    );
  }

  logout( {Function(String) onSuccess}){
    asyncRequestNetwork<String>(
        Method.post, HttpApi.logout,
        onSuccess: onSuccess
    );
  }

  isRole( int rid,{Function(String) onSuccess, Function(int code, String msg) onError}){
    asyncRequestNetwork<String>(
        Method.post, HttpApi.isRole,
        params:rid,
        onSuccess: onSuccess,
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