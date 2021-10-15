import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  Widget? child;
  BackGround({this.child});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        color: Colors.white,
        width: double.infinity,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              width: size.width * 0.58,
              child:  Image.asset('assets/login_bottom.png'),
            ),
            Positioned(
              left: 0,
              top: 0,
              width: size.width * 0.3,
              child: Image.asset('assets/main_top.png'),
            ),
            child!,
          ],
        ));
  }
}
