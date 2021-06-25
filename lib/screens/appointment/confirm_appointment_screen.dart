import 'package:booking_app/models/appointment.dart';
import 'package:booking_app/screens/home/home_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/widgets/filled_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConfirmAppointmentScreen extends StatelessWidget {
  final Appointment appointment;

  ConfirmAppointmentScreen({this.appointment});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: ListView(
          children: [
            Text(
              'Confirm Your Appointment',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'If you are happy with your current appointment details, hit the "Confirm Your Appointment" button below. If not, please return to the previous screen with the back arrow.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(height: 18),
            _detail(
              'Appointment ID',
              appointment.appointmentID.toString(),
            ),
            SizedBox(height: 10),
            _detail(
              'Appointment Date',
              '${DateFormat.yMMMd().format(appointment.date)} at ${appointment.time}',
            ),
            SizedBox(height: 10),
            _detail(
              'stylist',
              appointment.stylist.name,
            ),
            Divider(
              height: 36,
              color: Colors.grey[400],
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: 250,
                child: ListView.separated(
                  itemCount: appointment.services.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        appointment.services[index].name,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '\$${appointment.services[index].price}',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                ),
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'TAX',
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
                Text(
                  '\$${appointment.getTax()}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${appointment.getTotal()}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                  ),
                )
              ],
            ),
            Divider(
              height: 36,
              color: Colors.grey[400],
            ),
            FilledButton(
              text: 'CONFIRM YOUR APPOINTMENT',
              onPressed: () async {
                await Database.instance.createAppointment(appointment);
                await Authentication.instance
                    .getCurrentUser()
                    .setUpcomingAppointment(
                      appointment,
                      update: true,
                    );

                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'APPOINTMENT BOOKED!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Container(
                      width: 300,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your appointment has been booked',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Your appointment for ${DateFormat.yMMMMd().format(appointment.date)} has been booked!',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => HomeScreen(),
                  ),
                  ModalRoute.withName('/'),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _detail(final String title, final String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
