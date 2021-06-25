import 'dart:math';

import 'package:booking_app/constants.dart';
import 'package:booking_app/models/appointment.dart';
import 'package:booking_app/models/schedule.dart';
import 'package:booking_app/models/service.dart';
import 'package:booking_app/models/stylist.dart';
import 'package:booking_app/screens/appointment/confirm_appointment_screen.dart';
import 'package:booking_app/screens/appointment/widgets/service_tile.dart';
import 'package:booking_app/screens/appointment/widgets/time_tile.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/utils.dart';
import 'package:booking_app/widgets/filled_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Stylist stylist;

  BookAppointmentScreen(this.stylist);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime _focusedDate = DateTime.now();
  DateTime _selectedDate;

  final List<ServiceTile> _serviceTiles = [];
  final List<Service> _selectedServices = [];

  bool _isLoading = false;
  final List<TimeTile> _timeTiles = [];
  TimeTile _selectedTime;

  @override
  void initState() {
    super.initState();

    _selectedServices.clear();
    _serviceTiles.clear();
    for (final service in widget.stylist.services) {
      _serviceTiles.add(
        ServiceTile(
          service: service,
          isSelected: false,
        ),
      );
    }

    _timeTiles.clear();
    _selectedTime = null;

    _isLoading = false;
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: ListView(
          children: [
            Text(
              'Book Your Appointment',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'To book your appointment with ${widget.stylist.name}, select a date, select the service(s) you require, and the time.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
              ),
            ),
            SizedBox(height: 25),
            Container(
              decoration: Constants.containerDecoration,
              child: TableCalendar(
                focusedDay: _focusedDate,
                firstDay:
                    DateTime(DateTime.now().year, DateTime.now().month, 1),
                lastDay: DateTime(DateTime.now().year, 12, 31),
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                enabledDayPredicate: (day) => !Utils.removeTime(day).isBefore(
                  Utils.removeTime(DateTime.now()),
                ),
                onDaySelected: (selectedDay, focusedDay) async {
                  setState(
                    () {
                      _focusedDate = focusedDay;
                      _selectedDate = Utils.removeTime(selectedDay);
                    },
                  );

                  setState(() {
                    _isLoading = true;
                  });

                  _selectedTime = null;
                  _timeTiles.clear();
                  final List<String> availableTimes =
                      await _availableTimes(selectedDay);
                  for (final time in availableTimes) {
                    _timeTiles.add(
                      TimeTile(
                        time: time,
                        isSelected: false,
                      ),
                    );
                  }

                  setState(() {
                    _isLoading = false;
                  });
                },
                calendarStyle: CalendarStyle(
                  disabledTextStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                  weekendTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  todayDecoration: BoxDecoration(),
                  todayTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  defaultTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                  outsideTextStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                headerStyle: HeaderStyle(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  formatButtonVisible: false,
                  headerPadding: EdgeInsets.only(top: 12, bottom: 12),
                  headerMargin: EdgeInsets.only(bottom: 15),
                  leftChevronPadding: EdgeInsets.all(0),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                    size: 15,
                  ),
                  rightChevronPadding: EdgeInsets.all(0),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                    size: 15,
                  ),
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            if (_selectedDate != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELECT YOUR SERVICE(S)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    height: ((45 + 5) * _serviceTiles.length).toDouble() - 5,
                    child: ListView.separated(
                      itemCount: _serviceTiles.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _serviceTiles[index].isSelected =
                                !_serviceTiles[index].isSelected;
                          });

                          if (_serviceTiles[index].isSelected)
                            _selectedServices.add(
                              _serviceTiles[index].service,
                            );
                          else
                            _selectedServices.remove(
                              _serviceTiles[index].service,
                            );
                        },
                        child: ServiceTile(
                          service: _serviceTiles[index].service,
                          isSelected: _serviceTiles[index].isSelected,
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(height: 5),
                    ),
                  ),
                ],
              ),
            if ((_selectedDate != null))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Text(
                    'SELECT A TIME',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  if (_isLoading)
                    Container(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    )
                  else if (_timeTiles.isEmpty)
                    Text(
                      '${widget.stylist.name} is not available on ${Utils.toFormatted(_selectedDate)}. Please select another date.',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 35,
                      child: ListView.separated(
                        itemCount: _timeTiles.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (_selectedTime != null)
                                  _selectedTime.isSelected = false;

                                _timeTiles[index].isSelected =
                                    !_timeTiles[index].isSelected;
                                _selectedTime = _timeTiles[index];
                              },
                            );
                          },
                          child: TimeTile(
                            time: _timeTiles[index].time,
                            isSelected: _timeTiles[index].isSelected,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 5),
                      ),
                    ),
                  SizedBox(height: 25),
                ],
              ),
            FilledButton(
              width: MediaQuery.of(context).size.width.toInt(),
              height: 45,
              text: 'CONTINUE',
              onPressed: () {
                if (((_selectedDate != null) &&
                    (_selectedServices.isNotEmpty) &&
                    (_selectedTime != null))) {
                  final Appointment appointment = Appointment(
                    appointmentID: Random().nextInt(100000),
                    date: _selectedDate,
                    time: _selectedTime.time,
                    services: _selectedServices,
                    stylist: widget.stylist,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmAppointmentScreen(
                        appointment: appointment,
                      ),
                    ),
                  );
                }
              },
              fillColor: ((_selectedDate != null) &&
                      (_selectedServices.isNotEmpty) &&
                      (_selectedTime != null))
                  ? Colors.black
                  : Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }

  Future<List<String>> _availableTimes(final DateTime date) async {
    final List<String> availableTimes = [];

    final List<String> weekdays = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];

    final int weekdayIndex = date.weekday - 1;
    final Schedule schedule = widget.stylist.schedule;
    if (schedule.workingHours.containsKey(weekdays[weekdayIndex])) {
      for (final time in schedule.workingHours[weekdays[weekdayIndex]]) {
        final bool isAvailable = await Database.instance
            .isStylistAvailable(widget.stylist, date, time);
        if (isAvailable) {
          availableTimes.add(time);
        }
      }
    }

    return availableTimes;
  }
}
