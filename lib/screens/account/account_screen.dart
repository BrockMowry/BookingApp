import 'package:booking_app/constants.dart';
import 'package:booking_app/screens/appointment/upcoming_appointment_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/widgets/stylist_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
                        'https://blog.payroc.com/hubfs/guilherme-petri-602659-unsplash%20%281%29.jpg',
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        user.fullName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        user.emailAddress,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                        ),
                      )
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
                'ACCOUNT',
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
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Text(
                'MANAGE YOUR ACCOUNT',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.only(left: 18, right: 18),
              decoration: Constants.containerDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _button(
                    'Request an email change.',
                    'Request to change the email you use to sign in.',
                    () => {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      height: 5,
                      color: Colors.grey[300],
                    ),
                  ),
                  _button(
                    'Change your password.',
                    'Change the password you use to sign in.',
                    () => {},
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Divider(
                      height: 5,
                      color: Colors.grey[300],
                    ),
                  ),
                  _button(
                    'Disable your account.',
                    'Mark your account for deletion by disabling it.',
                    () => {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            if (user.getUpcomingAppointment() != null)
              Padding(
                padding: EdgeInsets.only(left: 18, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR UPCOMING APPOINTMENT',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        print('navigate');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpcomingAppointmentScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat.yMMMMd().format(
                                      user.getUpcomingAppointment().date,
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
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
                            ),
                            Container(
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'View more information about your appointment',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 17,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Text(
                user.favouriteStylists.length != 1
                    ? 'MY FAVOURITE STYLISTS'
                    : 'MY FAVOURITE STYLIST',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 18, right: 18),
              decoration: Constants.containerDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user.favouriteStylists.isEmpty)
                    Text(
                      'You do not have any favourite stylists...',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: (120 + 10) * user.favouriteStylists.length -
                          10.toDouble(),
                      child: ListView.separated(
                        itemCount: user.favouriteStylists.length,
                        itemBuilder: (context, index) {
                          final item = user.favouriteStylists[index];
                          return Dismissible(
                            key: Key(item.name),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(
                                () => user.removeFavouriteStylist(item),
                              );
                            },
                            background: Container(
                              margin: EdgeInsets.all(10),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).primaryColor,
                                size: 25,
                              ),
                            ),
                            child: StylistCard(
                              stylist: user.favouriteStylists[index],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 10,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(
    final String text,
    final String tagline,
    final Function onPressed,
  ) {
    return Container(
      width: double.infinity,
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        tagline,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
