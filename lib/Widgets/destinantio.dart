import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Destination {
  const Destination(this.id, this.title, this.icon);
  final int id;
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = [
  Destination(0, 'Home', Icons.home),
  Destination(1, 'Add Place', FontAwesomeIcons.user),
  Destination(2, 'Sub Access Page', Icons.people),
];
