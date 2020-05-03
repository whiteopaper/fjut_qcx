
import 'package:flutter/material.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';

class BaseListProvider<T> extends ChangeNotifier {

  final List<T> _list = [];
  List<T> get list => _list;

  int _page = 1;
  int get page => _page;

  /// 是否正在加载数据
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  StateType _stateType = StateType.loading;
  bool _hasMore = true;

  StateType get stateType => _stateType;
  bool get hasMore => _hasMore;

  void setStateTypeNotNotify(StateType stateType) {
    _stateType = stateType;
  }

  void setStateType(StateType stateType) {
    _stateType = stateType;
    notifyListeners();
  }

  void setHasMore(bool hasMore) {
    _hasMore = hasMore;
  }

  void increase() {
    _page++;
  }

  void toggle() {
    _isLoading = !_isLoading;
  }

  void add(T data) {
    _list.add(data);
    notifyListeners();
  }

  void addAll(List<T> data) {
    _list.addAll(data);
    notifyListeners();
  }

  void insert(int i, T data) {
    _list.insert(i, data);
    notifyListeners();
  }

  void insertAll(int i, List<T> data) {
    _list.insertAll(i, data);
    notifyListeners();
  }

  void remove(T data) {
    _list.remove(data);
    notifyListeners();
  }

  void removeAt(int i) {
    _list.removeAt(i);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }

  void refresh() {
    _page = 1;
    notifyListeners();
  }
}