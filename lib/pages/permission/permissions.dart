import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_apk/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_apk/pages/splash/splash.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsState();
}

class _PermissionsState extends State<PermissionsScreen> {
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
                  image: AssetImage('assets/hand-wave.png'),
                  color: Colors.white,
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  'Hejka!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Text(
                  'Aplikacja ${Constants
                      .appTitle} potrzebuje do działania \nprzybliżonej lokalizacji urządzenia.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40,
            child: Container(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: TextButton(

                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        color: Colors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onPressed: () async {
                      var perms = await Permission.location.request();
                      if (perms.isGranted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Splash()),
                        );
                      }else if (await Permission.location.isPermanentlyDenied){
                         AppSettings.openAppSettings(type: AppSettingsType.location);
                      }
                    },
                    child: Text('Zgoda!',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 20)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
