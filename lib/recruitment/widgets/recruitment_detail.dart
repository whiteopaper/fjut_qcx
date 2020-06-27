
import 'package:flutter/material.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/theme_utils.dart';
import 'package:flutter_html/flutter_html.dart';

class RecruitmentDetail extends StatelessWidget {

  const RecruitmentDetail({
    Key key,
    @required this.data,
  }) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle = Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);

    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: _container(context)
    );
  }

  Widget _container(BuildContext context) {
    return Html(
      data: """<p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">一、大会时间、地点</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">时间：</span>201</span><span style=\";font-family:仿宋;font-size:21px\">9</span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">年</span>1</span><span style=\";font-family:仿宋;font-size:21px\">1</span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">月</span></span><span style=\";font-family:仿宋;font-size:21px\">30</span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">日（星期六）</span>8:00－14:00；</span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">地点：福建工程学院旗山北校区田径场</span></span></p><p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">二、大会内容</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（一）用人单位与毕业生（人才）供需见面对接洽谈；</span></span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（二）现场为毕业生提供就业政策咨询、就业推荐，为建设行业企业提供现场咨询服务等。</span></span></p><p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">三、主办、承办和网络支持单位</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">（一）主办单位</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">福建省住房和城乡建设厅、福建省</span></span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">教育厅、</span></span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">福建工程学院。</span></span></p><p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">（二）承办单位</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">福建省住房和城乡建设厅人事处、福建省</span></span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">教育厅学生工作处、</span></span><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">福建建筑人才服务中心、福建工程学院学生工作部（处）。</span></span></p><p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">（三）网络支持</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">福建省毕业生就业公共网</span>(www.fjbys.gov.cn)、福建省住房和城乡建设网（www.fjjs.gov.cn）、福建建筑人才网(</span><a href=\"http://www.fjjzrc.com/\"><span style=\";font-family:仿宋;font-size:21px\">www.fjjzrc.com</span></a><span style=\";font-family:仿宋;font-size:21px\">)、福建工程学院苍霞人才网（jiuye.fjut.edu.cn）及省内外各高校校园网。</span></p><p style=\"text-indent:43px;line-height:36px\"><strong><span style=\"font-family: 仿宋;font-size: 21px\"><span style=\"font-family:仿宋\">四、参会对象</span></span></strong></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（一）房屋建筑、机电、安装、水利电力、市政、工程监理、造价咨询、建筑装饰、园林、钢结构、建筑防水、建筑智能、环保、桥梁等企业；</span></span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（二）建筑设计、城乡规划、建筑材料等设计单位；</span></span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（三）房地产开发、房产评估、物业管理等单位；</span></span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（四）其它各类相关企事业用人单位；</span></span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（五）</span>2019年应届大中专毕业生、毕业研究生；</span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">（六）往届未就业毕业生、技能型人才、中高级技术人才和台湾青年人才。</span></span></p><p style=\"text-indent:43px;line-height:36px\"><span style=\";font-family:仿宋;font-size:21px\"><span style=\"font-family:仿宋\">更多内容请点击查看&nbsp;<a href=\"https://jiuye.fjut.edu.cn/cmss/gs/10795.html\">https://jiuye.fjut.edu.cn/cmss/gs/10795.html</a></span></span></p><p><br/></p>
      """,
      //Optional parameters:
      padding: EdgeInsets.all(8.0),
      backgroundColor: Colors.white70,
      defaultTextStyle: TextStyle(fontFamily: 'serif'),
//      onLinkTap: (url) {
//        // open url in a webview
//      },
//      customRender: (node, children) {
//        if (node is dom.Element) {
//          switch (node.localName) {
//            case "video":
//              return Chewie(...);
//            case "custom_tag":
//              return CustomWidget(...);
//          }
//        }
//      },
    );
  }
}

