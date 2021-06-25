import 'package:booking_app/constants.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Authentication.instance.getCurrentUser();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Upcoming Appointment',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Here is some information about your upcoming appointment.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: Constants.containerDecoration.copyWith(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://media.blogto.com/articles/20201127-salons.jpg?w=2048&cmd=resize_then_crop&height=1365&quality=70',
                    ),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.6),
                      BlendMode.darken,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(
                            user.getUpcomingAppointment().date,
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          user.getUpcomingAppointment().time,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${user.getUpcomingAppointment().appointmentID}',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          user.fullName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            FilledButton(
              width: MediaQuery.of(context).size.width.toInt(),
              text: 'CANCEL THIS APPOINTMENT',
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'CONFIRM CANCELLATION',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Container(
                      width: 275,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Are you sure you want to cancel?',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'If you wish to continue with the cancellation of this appointment, hit "Yes". However, be aware that this action is irreversible.',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 15),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    await Database.instance.cancelAppointment(
                                      user.getUpcomingAppointment(),
                                    );
                                    user.deleteUpcomingAppointment();

                                    Navigator.pop(context);

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomeScreen(),
                                      ),
                                      ModalRoute.withName('/'),
                                    );
                                  },
                                  child: Text(
                                    'Yes, cancel my appointment',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
