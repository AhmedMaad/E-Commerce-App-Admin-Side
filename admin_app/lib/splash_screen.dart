import 'package:flutter/material.dart';
import 'dart:async';

//hena da bta3 el next page
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  //sh8l el function dii b3d ma t5ls
  startTime() async {
    var _duration = new Duration(seconds: 6);
    return new Timer(_duration, navigationPage);
  }

// hena brdo next page bdl OnboardingScreen
  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    /* Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomeScreen()));*/
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 5));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: new Color(0xff622F74),
            gradient: new LinearGradient(
              colors: [new Color(0xff622F74), new Color(0xffde5cbc)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 75.0,
                child: Container(
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.deepPurple,
                    size: animation.value * 150.0,
                  ),
                ),
              ),
              width: animation.value * 200,
              height: animation.value * 200,
            ),
            Container(
              child: Text(
                'Hello Admin',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
