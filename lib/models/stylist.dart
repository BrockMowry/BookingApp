import 'package:booking_app/models/schedule.dart';
import 'package:booking_app/models/service.dart';

class Stylist {
  final String name;
  final String job;
  final String bio;
  final String email;
  final String phoneNumber;
  final String imageUrl;
  final List<Service> services;
  final Schedule schedule;

  Stylist({
    this.name,
    this.job,
    this.bio,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.services,
    this.schedule,
  });
}
