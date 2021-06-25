import 'package:booking_app/constants.dart';
import 'package:booking_app/models/schedule.dart';
import 'package:booking_app/models/service.dart';
import 'package:booking_app/models/stylist.dart';
import 'package:booking_app/screens/appointment/book_appointment_screen.dart';
import 'package:booking_app/screens/appointment/upcoming_appointment_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/widgets/filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StylistScreen extends StatefulWidget {
  final Stylist stylist;

  StylistScreen({this.stylist});

  @override
  _StylistScreenState createState() => _StylistScreenState();
}

class _StylistScreenState extends State<StylistScreen> {
  @override
  Widget build(final BuildContext context) {
    final user = Authentication.instance.getCurrentUser();

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (final BuildContext context, final bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.stylist.imageUrl,
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        child: Text(
                          widget.stylist.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              if (user.isFavouriteStylist(widget.stylist)) {
                                user.removeFavouriteStylist(widget.stylist);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${widget.stylist.name} was removed from your favourites.'),
                                  ),
                                );

                                return;
                              }

                              user.addFavouriteStylist(widget.stylist);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${widget.stylist.name} was added to your favourites.'),
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          user.isFavouriteStylist(widget.stylist)
                              ? Icons.star
                              : Icons.star_border,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              collapsedHeight: 55,
              toolbarHeight: 55,
              expandedHeight: 250,
              pinned: true,
              floating: false,
              centerTitle: true,
              title: Text(
                widget.stylist.name.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.only(left: 18, right: 18, bottom: 25),
          child: ListView(
            children: [
              Text(
                widget.stylist.bio,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 18),
              Text(
                'CONTACT ${widget.stylist.name.split(' ')[0].toUpperCase()}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Container(
                decoration: Constants.containerDecoration,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.phone,
                          size: 14,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4),
                        Container(
                          width: 1,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4),
                        Text(
                          widget.stylist.phoneNumber,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.email,
                          size: 14,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.stylist.email,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Text(
                'SERVICES',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: Constants.containerDecoration,
                child: Container(
                  width: double.infinity,
                  height:
                      (30 + 5) * widget.stylist.services.length.toDouble() - 5,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.stylist.services.length,
                    itemBuilder: (context, index) => _service(
                      widget.stylist.services[index],
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: 5,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
              Text(
                'SCHEDULE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                decoration: Constants.containerDecoration,
                child: Container(
                  width: double.infinity,
                  height: (30 + 5) *
                          widget.stylist.schedule.schedule.length.toDouble() -
                      5,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.stylist.schedule.schedule.length,
                    itemBuilder: (context, index) => _schedule(
                      widget.stylist.schedule,
                      index,
                    ),
                    separatorBuilder: (context, index) => Divider(
                      height: 5,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FilledButton(
        text: 'BOOK WITH ${widget.stylist.name}',
        onPressed: () {
          if (user.getUpcomingAppointment() != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UpcomingAppointmentScreen(),
              ),
            );

            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookAppointmentScreen(
                widget.stylist,
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _service(final Service service) {
    return Container(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          Text(
            '\$${service.price}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _schedule(final Schedule schedule, final int index) {
    final List<String> weekdays = schedule.schedule.keys.toList();
    final String weekday = weekdays[index];

    return Container(
      width: double.infinity,
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${weekday.substring(0, 1).toUpperCase()}${weekday.substring(1).toLowerCase()}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
          ),
          Text(
            '${schedule.schedule[weekday][0]} - ${schedule.schedule[weekday][1]}',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
