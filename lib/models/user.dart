import 'package:booking_app/models/appointment.dart';
import 'package:booking_app/models/stylist.dart';
import 'package:booking_app/services/database.dart';
import 'package:booking_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BAUser {
  final String uniqueID;
  final String fullName;
  final String emailAddress;
  final bool isDisabled;
  final List<Stylist> favouriteStylists = [];

  Appointment _upcomingAppointment = null;

  BAUser({
    this.uniqueID,
    this.fullName,
    this.emailAddress,
    this.isDisabled = false,
  });

  bool isFavouriteStylist(final Stylist stylist) =>
      favouriteStylists.contains(stylist);

  void addFavouriteStylist(final Stylist stylist) {
    if (favouriteStylists.contains(stylist)) return;

    favouriteStylists.add(stylist);
    Database.instance.update(
      'users/$uniqueID',
      {
        'favouriteStylists': favouriteStylists.map((e) => e.name).toList(),
      },
    );
  }

  void removeFavouriteStylist(final Stylist stylist) {
    if (!favouriteStylists.contains(stylist)) return;

    favouriteStylists.remove(stylist);
    Database.instance.update(
      'users/$uniqueID',
      {
        'favouriteStylists': favouriteStylists.map((e) => e.name).toList(),
      },
    );
  }

  Appointment getUpcomingAppointment() {
    return _upcomingAppointment;
  }

  Future<void> setUpcomingAppointment(
    final Appointment appointment, {
    final bool update = false,
  }) async {
    this._upcomingAppointment = appointment;

    if (update)
      Database.instance.update(
        'users/$uniqueID',
        {
          'upcomingAppointment': {
            'date': Utils.toFormatted(appointment.date),
            'time': appointment.time,
          }
        },
      );
  }

  Future<void> deleteUpcomingAppointment() {
    this._upcomingAppointment = null;

    Database.instance.update(
      'users/$uniqueID',
      {
        'upcomingAppointment': FieldValue.delete(),
      },
    );
  }
}
