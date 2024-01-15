import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:waether/pages/splash/splash.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
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
  static String token = dotenv.get('API_KEY');
  static String waqi = dotenv.get('WAQI_TOKEN');

}
