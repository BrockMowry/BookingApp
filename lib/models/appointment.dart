import 'service.dart';
import 'stylist.dart';

class Appointment {
  final int appointmentID;
  final DateTime date;
  final String time;
  final Stylist stylist;
  final List<Service> services;

  Appointment(
      {this.appointmentID, this.date, this.time, this.stylist, this.services});

  double getServicesPrice() {
    double price = 0;
    services.forEach((element) => price += element.price);

    return price;
  }

  double getTax() {
    return double.parse((getServicesPrice() * 0.13).toStringAsFixed(2));
  }

  double getTotal() {
    return double.parse((getServicesPrice() + getTax()).toStringAsFixed(2));
  }
}
