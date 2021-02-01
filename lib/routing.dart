import 'package:flutter/material.dart';
import 'package:flutterpractice/screens/form_validation_screen.dart';
import 'package:flutterpractice/screens/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case "/form_validation":
        return MaterialPageRoute(builder: (context) => FormValidationScreen());
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Error Page"),
        ),
        body: MaterialApp(
          home: SafeArea(
            child: Text("Page Not Found!"),
          ),
        ),
      );
    });
  }
}
