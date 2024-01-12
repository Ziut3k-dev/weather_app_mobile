import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Air extends StatefulWidget {
  const Air({super.key});

  @override
  State<Air> createState() => _AirState();
}

class _AirState extends State<Air> {
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
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff4ACF8C),
                    Color(0xff75EDA6),
                  ],
                  transform: GradientRotation(0.820305)),
            ),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 85)),
                Text(
                  'Jakość powietrza',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 2)),
                Text(
                  'Bardzo dobra',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 65)),
                CircleAvatar(
                  radius: 91,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '20',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 64,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CAQI ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 5)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 73)),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                'PM 2,5',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2)),
                              Text(
                                '47%',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      VerticalDivider(
                        width: 48,
                        color: Colors.black,
                        thickness: 2,
                      ),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'PM 10',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2)),
                              Text(
                                '39%',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                    height: 1.2,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                Text(
                  'Wybrana stacja pomiarowa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      height: 1.2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 8)),
                Text(
                  'Wybrana stacja pomiarowa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 68)),
                Divider(
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(top: 14)),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    padding:
                        EdgeInsets.only(top: 8, bottom: 8, left: 31, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/happy.png'),
                        Padding(padding: EdgeInsets.only(left: 8)),
                        Text(
                          'Skorzystaj z dobrego powietrza i  wyjdź na spacer.',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              height: 1.2,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

bool havePermissions() {
  return true;
}
