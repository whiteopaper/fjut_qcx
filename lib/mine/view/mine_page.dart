import 'package:fjut_qcx/widgets/load_image.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.yellowAccent,
              height: 200.0,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight - 25,
                        child: LoadAssetImage("recruitment/recruitment_bg1")
                      ),
                      Positioned(
                        left: constraints.maxWidth / 2 - 25,
                        top: constraints.maxHeight - 50,
                        child: CircleAvatar(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: LoadAssetImage("recruitment/ic_check")
                          )
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              color: Colors.greenAccent,
              height: 300,
            )
          ],
        ),
      ),
    );
  }
}