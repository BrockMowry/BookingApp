import 'package:booking_app/models/salon_details.dart';
import 'package:booking_app/services/database.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    final salonDetails = Database.instance.salonDetails;

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
                      FittedBox(
                        child: Text(
                          salonDetails.salonName,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          salonDetails.tagline,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
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
                'ABOUT US',
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
          children: [Text('will be filled with backend stuff')],
        ),
      ),
    );
  }
}
