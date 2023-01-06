import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimationLoader extends StatefulWidget {
  const AnimationLoader({Key? key}) : super(key: key);

  @override
  _AnimationLoaderState createState() => _AnimationLoaderState();
}

class _AnimationLoaderState extends State<AnimationLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;
  final double initialRadius = 20;
  double radius = 0;
  String textMessage = "Please Wait....";

  Future _message() async {
    Timer(Duration(seconds: 1), () {
      setState(() {
        textMessage = "Your Location Search";
      });
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        textMessage = "Your Location Is Find";
      });
    });
    Timer(Duration(seconds: 3), () {
      setState(() {
        textMessage = "Your Location Is Saved";
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation_rotation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0, 1, curve: Curves.linear)));
    animation_radius_in = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.75, 1, curve: Curves.elasticIn),
      ),
    );

    animation_radius_out = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0, 0.25, curve: Curves.elasticOut),
      ),
    );

    controller.addListener(() {
      setState(() {
        if (controller.value >= 0.75 && controller.value <= 1) {
          radius = animation_radius_in.value * initialRadius;
        } else if (controller.value >= 0 && controller.value <= 0.25) {
          radius = animation_radius_out.value * initialRadius;
        }
      });
    });
    controller.repeat();
    _message();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              child: Center(
                child: RotationTransition(
                  turns: animation_rotation,
                  child: Stack(
                    children: [
                      const Dot(color: Colors.black26, radius: 25),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(pi / 4),
                          radius * sin(pi / 4),
                        ),
                        child: const Dot(color: Colors.redAccent, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(2 * pi / 4),
                          radius * sin(2 * pi / 4),
                        ),
                        child: const Dot(color: Colors.blueAccent, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(3 * pi / 4),
                          radius * sin(3 * pi / 4),
                        ),
                        child: const Dot(color: Colors.greenAccent, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(4 * pi / 4),
                          radius * sin(4 * pi / 4),
                        ),
                        child: const Dot(color: Colors.brown, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(5 * pi / 4),
                          radius * sin(5 * pi / 4),
                        ),
                        child: const Dot(color: Colors.pinkAccent, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(6 * pi / 4),
                          radius * sin(6 * pi / 4),
                        ),
                        child: const Dot(color: Colors.orangeAccent, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(7 * pi / 4),
                          radius * sin(7 * pi / 4),
                        ),
                        child: const Dot(
                            color: Colors.deepPurpleAccent, radius: 5),
                      ),
                      Transform.translate(
                        offset: Offset(
                          radius * cos(8 * pi / 4),
                          radius * sin(8 * pi / 4),
                        ),
                        child: const Dot(color: Colors.green, radius: 5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text("${textMessage}"),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;
  const Dot({Key? key, required this.color, required this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
