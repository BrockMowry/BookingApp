import 'package:flutter/material.dart';

class Constants {
  static final BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        blurRadius: 3,
        color: Colors.black.withOpacity(0.2),
      ),
    ],
  );

  static InputDecoration decoration(final hintText, final icon) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(
        icon,
        size: 15,
        color: Colors.black,
      ),
      contentPadding: EdgeInsets.all(10),
      fillColor: Colors.grey[200].withOpacity(0.7),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.red[400],
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.red[400],
        ),
      ),
    );
  }
}
