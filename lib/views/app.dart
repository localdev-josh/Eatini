import 'package:eatory_v1/views/restaurants/restaurant_listing.dart';
import 'package:eatory_v1/shared/widgets/strings.dart';
import 'package:flutter/material.dart';

void main() => runApp(AppRoot());

class AppRoot extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RestaurantListing(),
      debugShowCheckedModeBanner: false,
      title: Strings.appTitle,
    );
  }
}