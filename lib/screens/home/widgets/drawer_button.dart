import 'package:flutter/material.dart';

class DrawerButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;

  DrawerButton({this.title, this.icon, this.onPressed});

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Text(
              title.toLowerCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
