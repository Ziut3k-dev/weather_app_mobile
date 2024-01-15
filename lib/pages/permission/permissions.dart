import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waether/main.dart';

class Permissions extends StatefulWidget {
  const Permissions({super.key});
  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
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
                    'Aplikacja ${Constants.appTitle} potrzebuje do działania \nprzyblizonej loklizajcji urządzenia.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
