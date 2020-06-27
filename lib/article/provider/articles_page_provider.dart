import 'package:flutter/material.dart';

class ArticlesPageProvider extends ChangeNotifier {

  /// Tab的下标
  int _index = 0;
  int get index => _index;
  /// 数量
  List<int> _goodsCountList = [0, 0, 0, 0];
  List<int> get goodsCountList => _goodsCountList;

  void setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  void setGoodsCount(int count) {
    _goodsCountList[index] = count;
    notifyListeners();
  }
}