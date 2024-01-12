import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.weather});

  final Weather weather;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: getGradientByMood(widget.weather),
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 45)),
                    Image(
                      image:
                          AssetImage('assets/${getIconByMood(widget.weather)}'),
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 41)),
                    Text(
                      "${DateFormat.MMMMEEEEd('pl').format(DateTime.now())}, ${widget.weather.weatherDescription}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 12)),
                    Text(
                      '${widget.weather.temperature?.celsius?.floor()}℃',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 64,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Odczuwalna ${widget.weather.tempFeelsLike?.celsius?.floor()}℃',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 24)),
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 130,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Ciśnienie',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 2)),
                                  Text(
                                    '${widget.weather.pressure?.floor()} hPa',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          VerticalDivider(
                            width: 48,
                            color: Colors.white,
                            thickness: 2,
                          ),
                          SizedBox(
                            width: 130,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Wiatr',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        height: 1.2,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 2)),
                                  Text(
                                    '${widget.weather.windSpeed?.floor()} m/s',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontSize: 22,
                                        height: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 24)),
                    if (widget.weather.rainLastHour != null)
                      Text(
                        'Opady ${widget.weather.rainLastHour} mm/1h ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    if (widget.weather.snowLastHour != null)
                      Text(
                        'Opady ${widget.weather.snowLastHour} mm/1h ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    if (widget.weather.snowLastHour == null &&
                        widget.weather.rainLastHour == null)
                      Text(
                        'Brak opadów',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    Padding(padding: EdgeInsets.only(top: 68)),
                  ],
                ),
              ),
            ],
          ),
        );
  }

  String getIconByMood(Weather weather) {
    switch (weather.weatherMain) {
      case 'Thunderstorm':
        return 'weather-lightning.png';
      case 'Clouds' || 'Drizzle' || 'Snow':
        return 'weather-rain.png';
      default:
        return (isNight(weather) ? 'weather-moonny.png' : 'weather-sunny.png');
    }
  }

  bool isNight(Weather weather) {
    if (weather.sunrise is DateTime && weather.sunset is DateTime) {
      return DateTime.now().isAfter(weather.sunset!) ||
          DateTime.now().isBefore(weather.sunrise!);
    } else {
      return true;
    }
  }

  LinearGradient getGradientByMood(Weather weather) {
    var main = weather.weatherMain;
    if (main == 'Clouds' || main == 'Drizzle' || main == "Snow") {
      return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xff6E6CD8), Color(0xff40A0EF), Color(0xff77E1EE)]);
    } else if (main == 'Thunderstorm' || isNight(weather)) {
      return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Color(0xff313545), Color(0xff121118)]);
    } else {
      return LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [Color(0xff5283F0), Color(0xffCDEDD4)]);
    }
  }
}
