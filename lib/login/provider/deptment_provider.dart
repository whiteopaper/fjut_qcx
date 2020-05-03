
import 'package:fjut_qcx/login/presenter/Login_presenter.dart';
import 'package:flutter/material.dart';

class DepartmentSortProvider extends ChangeNotifier {

  int _index = 0;
  int get index => _index;

  // TabBar初始化3个，其中两个文字置空。
  List<Tab> _myTabs = <Tab>[Tab(text: '请选择'), Tab(text: ''), Tab(text: '')];
  get myTabs => _myTabs;

  /// 当前列表数据
  List _mList = [] ;
  get mList => _mList;

  /// 三级联动选择的position
  var _positions = [0, 0, 0];
  get positions => _positions;
  /// 数据源
  List data;
  /// 组合部门名
  String deptName;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void indexIncrement() {
    _index ++;
  }

  void setList(int index) {
    switch(index) {
      case 0:
        _mList = data;
        break;
      case 1:
        Map<String, dynamic> parent =data[positions[0]];
        _mList = parent["childrens"];
        verify(parent);
        break;
      case 2:
        Map<String, dynamic> parent = data[positions[0]]["childrens"][positions[1]];
        _mList = parent["childrens"];
        verify(parent);
        break;
    }
  }

  void setListAndChangeTab() {
    switch(index) {
      case 1:
        Map<String, dynamic> parent = data[positions[0]];
        _mList = parent["childrens"];
        verify(parent);
        _myTabs[1] = Tab(text: '请选择');
        _myTabs[2] = Tab(text: '');
        break;
      case 2:
        Map<String, dynamic> parent = data[positions[0]]["childrens"][positions[1]];
        _mList = parent["childrens"];
        verify(parent);
        _myTabs[2] = Tab(text: '请选择');
        break;
      case 3:
        Map<String, dynamic> parent = data[positions[0]]["childrens"][positions[1]];
        _mList = parent["childrens"];
        verify(parent);
        deptName = data[positions[0]]["name"] +
            "/" + data[positions[0]]["childrens"][positions[1]]["name"] +
            "/" +_mList[positions[2]]["name"];
        break;
    }
    notifyListeners();
  }

  void initData() {

    if (_mList.isNotEmpty) {
      return;
    }

    LoginPresenter presenter = new LoginPresenter();
    presenter.departments(
      onSuccessList: (data){
        this.data = data  ;
        _mList = data;
        notifyListeners();
      }
    );
  }

  void verify(Map<String, dynamic> parent){
    if (_mList == null){
      Map<String, dynamic> empty = Map();
      empty["id"] = parent["id"];
      empty["name"] = "默认分组";
      _mList = [empty];
    }
  }
}