
import 'package:fjut_qcx/login/models/auth/user_entity.dart';
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
      onError: (code, msg) {
        Toast.show(msg);
      }
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

  registerNext(UserModel currentUser, String vsername, String email, int deptid, {Function(String t) onSuccess}){
    Map<String, dynamic> params = currentUser.toJson();
    params['vsername'] = vsername;
    params['email'] = email;
    params['deptid'] = deptid;
    asyncRequestNetwork<String>(
        Method.post, HttpApi.modifyPersonalInfo,
        params: params,
        onSuccess: onSuccess,
        onError: (code, msg) {
          Toast.show(msg);
        }

    );
  }


  //登录-刷新用户信息
  info( {Function(Map<String, dynamic>) onSuccessMap}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.get, HttpApi.info,
        isMap: true,
        onSuccessMap: onSuccessMap,
        onError: (code, msg) {
          Toast.show(msg);
        }
    );
  }

  //注册-获取公开部门树
  departments( {Function(List<dynamic> list) onSuccessList}){
    DioUtils.instance.asyncRequestNetwork<dynamic>(
        Method.get, HttpApi.departments,
        isList: true,
        onSuccessList: onSuccessList,
        onError: (code, msg) {
          Toast.show(msg);
        }
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