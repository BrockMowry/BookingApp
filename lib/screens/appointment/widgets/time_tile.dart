import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  final String time;
  bool isSelected;

  TimeTile({
    this.time,
    this.isSelected = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 80,
      height: 35,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
