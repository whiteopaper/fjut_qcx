
import 'dart:collection';

class HttpApi{
  static const String baseUrl = 'http://47.115.150.4:8888';
  static const String imageUrl = 'http://47.115.150.4:8088/';
  static const String jieyeUrl = 'https://jiuye.fjut.edu.cn/weixin.php/WechatMobileInterface';
  static const String login = '/rest/user/login';
  static const String logout = '/rest/user/logout';
  static const String register = '/rest/user/register';
  static const String modifyPersonalInfo = '/rest/user/modifyPersonalInfo';
  static const String userInfo = '/rest/user/info';
  static const String isRole = '/rest/user/isRole';
  static const String departments = '/rest/department/all';

  static const String getResumes = '/rest/resume/list';
  static const String resumeQuery = '/rest/resume/info';
  static const String resumeAdd = '/rest/resume/add';
  static const String resumeUpdate = '/rest/resume/update';
  static const String resumeDelete = '/rest/resume/delete';
  static const String resumeCollection = '/rest/resume/collection';
  static const String resumeCancel = '/rest/resume/cancel';

  static const String getWorks = '/rest/work/list';
  static const String workQuery = '/rest/work/info';
  static const String workAdd = '/rest/work/add';
  static const String workUpdate = '/rest/work/update';
  static const String workDelete = '/rest/work/delete';
  static const String workCollection = '/rest/work/collection';
  static const String workCancel = '/rest/work/cancel';

  //学校api
  static const String jobfairList = '/jobfairList';
  static const String keynoteList = '/keynoteList';
  static const String recruitmentBrochureList = '/recruitmentBrochureList';

  static const String jobfairDetails = 'https://jiuye.fjut.edu.cn/weixin.php/WechatMobileView/jobfairDetails.html?jobfair_id=';
  static const String keynoteDetails = 'https://jiuye.fjut.edu.cn/weixin.php/WechatMobileView/keynoteDetails.html?keynoteId=';
  static const String brochureDetails = 'https://jiuye.fjut.edu.cn/weixin.php/WechatMobileView/brochureDetails.html?bid=';

  static const String getArticle = '/getArticle';
  static const String getArticleDetail = 'https://jiuye.fjut.edu.cn/weixin.php/WechatMobileView/informationArticleDetail?type=2&id=';

  static const String uploadIcon = '/rest/upload/icon';
  static const String uploadLicense = '/rest/upload/license';
}