
import 'package:fjut_qcx/market/widget/resumes_list.dart';
import 'package:fjut_qcx/market/widget/works_list.dart';
import 'package:fjut_qcx/res/gaps.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';
import 'package:flutter/material.dart';

class MarketListPage<T> extends StatefulWidget {

  const MarketListPage({
    Key key,
    this.index,
    this.isStudent,
    this.isCompany,
  }): super(key: key);

  final int index;
  final bool isStudent;
  final bool isCompany;

  @override
  MarketListPageState<T> createState() => MarketListPageState<T>();
}

class MarketListPageState<T> extends State<MarketListPage>{


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  void getData(){

  }


  @override
  Widget build(BuildContext context) {
    return _container(context);
  }

  Widget _container(BuildContext context) {
    if (widget.index==0){
      return widget.isCompany?ResumesList()
          :StateLayout(type: StateType.noPermission);
    }
    if (widget.index==1){
      return widget.isStudent?WorksList()
          :StateLayout(type: StateType.noPermission);
    }
    return Gaps.empty;
  }
}
