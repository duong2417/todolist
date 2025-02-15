import 'package:flutter/material.dart';
import 'route.dart';

class SplashSCREEN extends StatefulWidget {
  const SplashSCREEN({super.key});

  @override
  State<SplashSCREEN> createState() => _SplashSCREENState();
}

class _SplashSCREENState extends State<SplashSCREEN> {
  double sizeSTART = 0, sizeEND = 200;
  int duration = 1000;
  double opacitySTART = 1, opacityEND = 1;
  @override
  void initState() {
    super.initState();
    animate();
  }

  void animate() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        opacityEND = 0;
        sizeEND = 400;
        duration = 200;
      });
      Future.delayed(Duration(milliseconds: duration)).then(
        (value) {
          Navigator.pushReplacementNamed(context, ROUTE.todoSCREEN);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: sizeSTART, end: sizeEND),
        builder: (BuildContext context, double size, Widget? child) {
          return TweenAnimationBuilder(
              tween: Tween<double>(begin: opacitySTART, end: opacityEND),
              duration: Duration(
                milliseconds: duration,
              ),
              builder: (BuildContext context, double opacity, Widget? child) {
                return Opacity(
                    opacity: opacity,
                    child: SizedBox(
                      width:70, height:70,
                      child: Image.network(
                        'https://www.pngkit.com/png/full/924-9245281_todo-list-icon-do-list-icon-png.png',
                        width: size,
                        height: size,
                      ),
                    ));
              });
        },
        duration: Duration(milliseconds: duration),
      ),
    ));
  }
}
