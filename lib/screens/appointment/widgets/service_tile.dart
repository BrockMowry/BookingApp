import 'package:booking_app/models/service.dart';
import 'package:flutter/material.dart';

class ServiceTile extends StatelessWidget {
  final Service service;
  bool isSelected;

  ServiceTile({
    this.service,
    this.isSelected = false,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[300],
          width: 1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              service.name,
              style: TextStyle(
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey[300],
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                if (isSelected)
                  Row(
                    children: [
                      Icon(
                        Icons.done,
                        size: 15,
                        color: Colors.black,
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                Text(
                  '\$${service.price}',
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[300],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
