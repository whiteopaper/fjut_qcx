
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fjut_qcx/res/resources.dart';
import 'package:fjut_qcx/util/theme_utils.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title: '',
    this.centerTitle: '',
    this.action,
    this.actionName: '',
    this.backImg: 'assets/images/ic_back_black.png',
    this.onPressed,
    this.onPressedBack ,
    this.isBack: true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final Widget action;
  final String actionName;
  final VoidCallback onPressed;
  final VoidCallback onPressedBack;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = backgroundColor;
    }

    SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    var back = isBack ? IconButton(
      onPressed: onPressedBack??() {
        FocusScope.of(context).unfocus();
        Navigator.maybePop(context);
      },
      tooltip: 'Back',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        backImg,
        color: ThemeUtils.getIconColor(context),
      ),
    ) : Gaps.empty;

    var action = actionName.isNotEmpty ? Positioned(
      right: 0.0,
      child: Theme(
        data: Theme.of(context).copyWith(
            buttonTheme: ButtonThemeData(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              minWidth: 60.0,
            )
        ),
        child: this.action??FlatButton(
          child: Text(actionName, key: const Key('actionName')),
          textColor: ThemeUtils.isDark(context) ? Colours.dark_text : Colours.text,
          highlightColor: Colors.transparent,
          onPressed: onPressed,
        ),
      ),
    ) : Gaps.empty;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Semantics(
                namesRoute: true,
                header: true,
                child: Container(
                  alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
                  width: double.infinity,
                  child: Text(
                    title.isEmpty ? centerTitle : title,
                    style: TextStyle(fontSize: Dimens.font_sp16,)
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 48.0),
                ),
              ),
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
