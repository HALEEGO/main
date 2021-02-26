import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  @required
  final Widget child;
  const Background({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   top: -50,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/HA/song2.jpg",
          //     width: size.width * 1,
          //   ),
          // ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   child: Image.asset(
          //     "assets/images/HA/songE.jpg",
          //     width: size.width * 1,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}
