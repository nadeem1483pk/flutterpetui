import 'package:flutter/material.dart';
import 'package:petpal_ui/adoption_screen.dart';
import 'package:petpal_ui/menu_screen.dart';

class MenuFrame extends StatefulWidget {


  @override
  _MenuFrameState createState() => _MenuFrameState();
}

class _MenuFrameState extends State<MenuFrame> with SingleTickerProviderStateMixin {
   late AnimationController _animationController;
   late Animation<double> scaleAnimation;
  Duration duration = Duration(microseconds: 200);

   @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration );
    scaleAnimation = Tween<double>(begin: 1.0,end: 0.6 ).animate(_animationController);
  }
  @override
  Widget build(BuildContext context) {
     final devicewidth = MediaQuery.of(context).size.width;
    return Stack (
      children: <Widget>[
     MenuScreen(),
      AnimatedPositioned(duration: duration,
          top: 0,
          bottom: 0,
          left: devicewidth * 0.55,
          right: devicewidth * -0.45,
          child: ScaleTransition(
              scale: scaleAnimation,
              child: MenuScreen())),
    ],
    );
  }
}
