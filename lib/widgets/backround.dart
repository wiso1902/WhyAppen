import 'package:flutter/material.dart';

class BackroundImage extends StatelessWidget {
  const BackroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [Colors.deepOrange, Colors.orangeAccent],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image:  DecorationImage(
            image: AssetImage('assets/images/backround.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.orange, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}