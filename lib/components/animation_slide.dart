import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AnimationSlide extends StatefulWidget {
  AnimationSlide({Key? key,required this.title});
  final Widget title;
  @override
  _AnimationSlideState createState() => _AnimationSlideState();
}

class _AnimationSlideState extends State<AnimationSlide>with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _offsetFloat;


  @override
  void initState() {
    super.initState();

    //ToDo:second animation
    _controller = AnimationController(
      vsync:this,
      value: 0.1,
      duration: const Duration(seconds: 3),
    );

    _offsetFloat = Tween<Offset>(begin: Offset(2.0, 0.0), end: Offset.zero)
        .animate(_controller);
    _offsetFloat.addListener((){
      setState((){});
    });
    _controller.forward();



  }
  @override
  void dispose() {
    // Don't forget to dispose the animation controller on class destruction

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SlideTransition(
        position: _offsetFloat,
        child: widget.title
    );
  }
}