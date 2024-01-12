import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

// import 'package:waether/pages/home/home.dart';
// import 'package:waether/pages/splash/splash.dart';
// import 'package:waether/pages/weather/air.dart';
import 'package:waether/pages/splash/splash.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = Constants.appTitle;
    return const MaterialApp(
      title: title,
      locale: Locale('pl', 'PL'),
      home: Splash(),
      // home: HomePage(),
      // home: Air(),
    );
  }
}

class Constants {
  static const String appTitle = 'Weather Clear';
  static const String token = "be76c9ddaab299005686b742232b840b";
}
