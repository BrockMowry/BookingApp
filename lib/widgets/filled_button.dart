import 'package:flutter/material.dart';

class FilledButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color fillColor;
  final int width, height;

  FilledButton({
    this.text,
    this.onPressed,
    this.fillColor = Colors.black,
    this.width = 300,
    this.height = 45,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: width.toDouble(),
      height: height.toDouble(),
      child: MaterialButton(
        color: fillColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
