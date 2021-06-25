import 'package:flutter/material.dart';

class WifiRequired extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientIcon(
            Icons.wifi,
            120,
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                Colors.pink[600],
              ],
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Internet Connection Required!',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25),
            child: Text(
              'This app relies on an internet connection due to its extensive database use. Therefore, it cannot be used without a stable internet connection. Please close the app, connect to WiFi, then re-open the app.',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
