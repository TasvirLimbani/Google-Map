import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final double height;
  final double width;
  final double iconSize;
  final Color iconcolor;

  const CustomButton(
      {Key? key,
      required this.icon,
      required this.height,
      required this.width,
      this.iconcolor = Colors.white,
      required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey,
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.white,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(-4, -4),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white54,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    offset: Offset(5, 10),
                    spreadRadius: 3,
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -4),
                    spreadRadius: -2,
                    blurRadius: 20,
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(icon, size: iconSize, color: iconcolor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
