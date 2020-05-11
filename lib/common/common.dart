class Constant {
  /// debug开关，上线需要关闭
  /// App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false
  static const bool inProduction  = const bool.fromEnvironment('dart.vm.product');

  static bool isDriverTest  = false;
  static bool isUnitTest  = false;
  
  static const String data = 'result';
  static const String message = 'msg';
  static const String code = 'code';

  static const String jobfairList = 'jobfairList';
  static const String keynoteList = 'keynoteList';
  static const String dataList = 'dataList';

  //ok
  static const int CODE_200 = 20000;
  //error
  static const int CODE_500 = 50000;

  static const String currentUser = "currentUser";
  static const String keyGuide = 'keyGuide';
  static const String phone = 'phone';
  static const String accessToken = 'QcxAdmin-Token';
  static const String refreshToken = 'refreshToken';

  static const String theme = 'AppTheme';

}
