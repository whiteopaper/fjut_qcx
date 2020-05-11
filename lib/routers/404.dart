import 'package:flutter/material.dart';
import 'package:fjut_qcx/widgets/app_bar.dart';
import 'package:fjut_qcx/widgets/state_layout.dart';

class WidgetNotFound extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
      ),
      body: StateLayout(
        type: StateType.message,
        hintText: '页面不存在',
      ),
    );
  }
}
