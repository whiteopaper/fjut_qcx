
import 'package:fjut_qcx/common/common.dart';
import 'package:flustars/flustars.dart';
import 'package:fjut_qcx/mvp/base_page_presenter.dart';
import 'package:fjut_qcx/net/net.dart';
import 'package:fjut_qcx/login/page/login_page.dart';
import 'package:fjut_qcx/routers/fluro_navigator.dart';
import 'package:fjut_qcx/routers/routers.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';


class LoginPresenter{


  login<T>(String username, String password, Function(T t) onSuccess) {

    Map<String, String> params = Map();
    params['username'] = username;
    params['password'] = password;
    DioUtils.instance.asyncRequestNetwork<T>(
        Method.post, HttpApi.login,
        params: params,
        onSuccess: (data) {
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onError: (code, msg) {
        }
    );
  }
 
}