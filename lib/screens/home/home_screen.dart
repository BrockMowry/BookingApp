import 'package:booking_app/constants.dart';
import 'package:booking_app/screens/appointment/upcoming_appointment_screen.dart';
import 'package:booking_app/screens/home/aboutUs_screen.dart';
import 'package:booking_app/services/authentication.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/models/stylist.dart';
import 'package:booking_app/screens/account/account_screen.dart';
import 'package:booking_app/screens/home/stylist_screen.dart';
import 'package:booking_app/screens/home/widgets/drawer_button.dart';
import 'package:booking_app/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(final BuildContext context) {
    final user = Authentication.instance.getCurrentUser();

    return Scaffold(
      appBar: AppBar(),
      drawer: Container(
        width: 250,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'booking',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
                Text(
                  'app',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 35,
                  ),
                ),
                Spacer(),
                DrawerButton(
                  title: 'Home',
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(height: 10),
                DrawerButton(
                  title: 'Account',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                if (user.getUpcomingAppointment() != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerButton(
                        title: 'Your Appointment',
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpcomingAppointmentScreen(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                DrawerButton(
                  title: 'About Us',
                  onPressed: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutUsScreen(),
                      ),
                    );
                  },
                ),
                Spacer(),
                IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () async {
                    Navigator.pop(context);
                    Authentication.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                ),
                Spacer(),
                Text(
                  'version 1.0',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 18, right: 18),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Hello ${user.fullName.split(' ')[0]},',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "welcome to the ${Database.instance.salonDetails.salonName}'s official app.",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: Constants.containerDecoration,
              child: Center(
                child: Text(
                  'NEWS IMAGES...',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // child: Carousel(
              //   images: Database.INSTANCE.newsImages,
              //   dotSize: 3,
              //   dotBgColor: Colors.black.withOpacity(0.3),
              //   dotPosition: DotPosition.bottomCenter,
              //   dotSpacing: 20,
              //   indicatorBgPadding: 10,
              //   animationCurve: Curves.ease,
              //   animationDuration: Duration(seconds: 1),
              //   boxFit: BoxFit.fill,
              // ),
            ),
            SizedBox(height: 18),
            Container(
              width: double.infinity,
              height: 150,
              //margin: EdgeInsets.only(left: 18, right: 18),
              child: ListView.separated(
                itemCount: Database.instance.stylists.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => _stylistCard(
                  stylist: Database.instance.stylists[index],
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
              ),
            ),
            SizedBox(height: 18),
            Container(
              decoration: Constants.containerDecoration,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 25,
                    child: Divider(
                      height: 20,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text(
                    Database.instance.salonDetails.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 18),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Read more...',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _stylistCard({final Stylist stylist}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StylistScreen(
              stylist: stylist,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 125,
            height: 150,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      stylist.imageUrl,
                    ),
                    radius: 45,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          stylist.name,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          stylist.job,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
