import 'package:flutter/material.dart';
import 'dart:math' as Math;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: WidgetAniamtion(),
        ),
      );
}

//Aniamtion
class WidgetAniamtion extends StatefulWidget {
  @override
  _WidgetAniamtionState createState() => _WidgetAniamtionState();
}

class _WidgetAniamtionState extends State<WidgetAniamtion>
    with SingleTickerProviderStateMixin {
  //Necesssary to handle the aniamtion
  AnimationController aController;
  Animation<double> rotation;
  Animation<double> opacity;
  Animation<double> moveRight;
  Animation<double> scaleShape;

  @override
  void initState() {
    aController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );

    //Linear rotation
    //rotation = new Tween(begin: .0, end: 10.0 * Math.pi).animate(aController);

    //No linear rotation (Customizedb)
    rotation = new Tween(begin: .0, end: 10.0 * Math.pi).animate(
        CurvedAnimation(parent: aController, curve: Curves.easeInExpo));

    //opacity = new Tween(begin: .1, end: 1.0).animate(aController);
    opacity = new Tween(begin: .1, end: 1.0).animate(
        //Interval handles the time to make this animation
        CurvedAnimation(
            parent: aController,
            curve: Interval(0, 0.25, curve: Curves.easeInExpo)));

    moveRight = new Tween(begin: .1, end: 200.0).animate(aController);

    scaleShape = new Tween(begin: 0.0,end: 8.0).animate(aController);

    aController.addListener(() {
      print(aController.status);
      if (aController.status == AnimationStatus.completed) {
        aController.reverse();
      }

      if (aController.status == AnimationStatus.dismissed) {
        aController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    aController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Play animation
    aController.forward();
    return AnimatedBuilder(
        animation: aController,
        child: Rectangle(),
        builder: (_, widget) {

          return Transform.scale(
            scale: scaleShape.value,
            child: Transform.translate(
              offset: Offset(moveRight.value, 0),
              child: Transform.rotate(
                child: Opacity(
                  opacity: opacity.value,
                  child: widget,
                ),
                //The angle to rotate
                angle: rotation.value,
              ),
            ),
          );
        });
  }
}

//The shape
class Rectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: Colors.red),
    );
  }
}
