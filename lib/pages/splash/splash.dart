import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_apk/pages/home/home.dart';
import 'package:weather_app_apk/pages/permission/permissions.dart';
import 'package:air_quality_waqi/air_quality_waqi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';

import '../../main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              // color: Colors.transparent,
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color.fromARGB(255, 102, 113, 229),
                  Color.fromARGB(255, 72, 82, 217)
                ],
              ),
            ),
          ),
          Align(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/cloud-sun.png'),
                    color: Colors.white,
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Text(
                    Constants.appTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    'Aplikacja do monitrowania\n czystości powietrza',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Przywiewam dane...',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    havePermissions(context);
  }

  Future<void> executeOnceAfterBuild() async {
    // print(Constants.token);
    AirQualityWaqi waqi = AirQualityWaqi(Constants.waqi);
    AirQualityWaqiData waqiData = await waqi.feedFromCity('Wloclawek');
    // print(waqiData.toString());
    WeatherFactory wf = WeatherFactory(
      Constants.token,
      language: Language.POLISH,
    );
    Weather w = await wf.currentWeatherByCityName('Włocławek, PL');
    // log(w.toJson().toString());
    navigateToWeatherScreen(w, waqiData);
  }

  void navigateToWeatherScreen(Weather weather, AirQualityWaqiData waqiData) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(weather: weather, waqiData: waqiData)),
    );
  }

  void havePermissions(BuildContext context) async {
    var perms = Permission.location.status;
    if (await perms.isGranted) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        executeOnceAfterBuild();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PermissionsScreen()),
      );
    }
  }
}
