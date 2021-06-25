import 'package:booking_app/models/stylist.dart';
import 'package:flutter/material.dart';

class StylistCard extends StatelessWidget {
  final Stylist stylist;

  StylistCard({this.stylist});

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(stylist.imageUrl),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stylist.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  stylist.job,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Container(
                  width: 20,
                  child: Divider(
                    height: 18,
                    color: Colors.grey[400],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      size: 12,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      stylist.email,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.phone_android_outlined,
                      size: 12,
                      color: Colors.black,
                    ),
                    SizedBox(width: 5),
                    Text(
                      stylist.phoneNumber,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SmallStylistCard extends StatelessWidget {
  final Stylist stylist;
  bool isSelected;

  SmallStylistCard({this.stylist, this.isSelected});

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 125,
      height: 125,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[50] : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Colors.grey[200] : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              stylist.imageUrl,
            ),
            radius: 34,
          ),
          Column(
            children: [
              FittedBox(
                child: Text(
                  stylist.name,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  stylist.job,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
