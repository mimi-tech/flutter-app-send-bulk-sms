import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class FadeAnimation extends StatefulWidget {
  FadeAnimation({Key? key,required this.title});
  final Widget title;
  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(seconds: 7), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: animation,
        child: widget.title
    );

  }
}
