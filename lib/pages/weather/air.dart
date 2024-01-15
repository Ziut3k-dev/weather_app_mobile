import 'package:air_quality_waqi/air_quality_waqi.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Air extends StatefulWidget {
  const Air({super.key, required this.waqiData});

  final AirQualityWaqiData waqiData;

  @override
  State<Air> createState() => _AirState();
}

class _AirState extends State<Air> {
  PanelController _panelc = PanelController();

  late String quality;

  late String advice;
  late int isGood = 3;

  void setupLevel(int aqi) {
    if (aqi <= 100) {
      quality = "Bardzo dobra";
      advice = "Skorzystaj z dobrego powietrza i wyjdź na spacer";
      isGood = 1;
    } else if (aqi <= 150) {
      quality = "Nie za dobra";
      advice = "Jeśli tylko możesz zostań w domu, załatwiaj sprawy online";
      isGood = 2;
    } else {
      quality = "Bardzo zła!";
      advice = "Zdecydowanie zostań w domu i załatwiaj sprawy online!";
    }
  }

  AssetImage getAdviceImage(int isGood) {
    if (isGood == 1) {
      return AssetImage('assets/happy.png');
    } else if (isGood == 2) {
      return AssetImage('assets/ok.png');
    } else {
      return AssetImage('assets/sad.png');
    }
  }

  LinearGradient getGradientByMood(int isGood) {
    if (isGood == 1) {
      return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xff4acf8c),
            Color(0xff75eda6),
          ]);
    } else if (isGood == 2) {
      return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xfffbda61), Color(0xfff76b1c)]);
    } else {
      return LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xfff4003a), Color(0xffff8888)]);
    }
  }

  Widget getDangerValueBottom(int isGood) {
    if (isGood == 1 || isGood == 2) {
      return Image.asset('assets/danger-value-negative.png', scale: 0.9);
    } else {
      return Image.asset('assets/danger-value.png', scale: 0.9);
    }
  }

  Widget getDangerValueTop(int isGood) {
    if (isGood == 1) {
      return Image.asset('assets/danger-value-negative.png',
          color: Color(0xff4acf8c), scale: 0.9);
    } else if (isGood == 2) {
      return Image.asset('assets/danger-value-negative.png',
          color: Color(0xfffbda61), scale: 0.9);
    } else {
      return Image.asset('assets/danger-value.png',
          color: Color(0xfff4003a), scale: 0.9);
    }
  }

  Color getBackgroundTextColor(int isGood) {
    if (isGood == 1) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    setupLevel(widget.waqiData.airQualityIndex);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                // color: Colors.transparent,
                gradient: getGradientByMood(isGood)),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 85),
                ),
                Text(
                  'Jakość powietrza',
                  style: TextStyle(
                    color: getBackgroundTextColor(isGood),
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2),
                ),
                Text(
                  quality,
                  style: TextStyle(
                    color: getBackgroundTextColor(isGood),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 65),
                ),
                CircleAvatar(
                  radius: 91,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.waqiData.airQualityIndex}',
                        style: TextStyle(
                          color: getBackgroundTextColor(isGood),
                          fontSize: 64,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _panelc.open();
                                },
                              text: 'CAQI ',
                              style: TextStyle(
                                color: getBackgroundTextColor(isGood),
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 73),
                ),
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
                                    color: getBackgroundTextColor(isGood),
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                              ),
                              Text(
                                '${widget.waqiData.iaqi.pm25.floor()}%',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                    color: getBackgroundTextColor(isGood),
                                    height: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      VerticalDivider(
                        width: 48,
                        color: getBackgroundTextColor(isGood),
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
                                    color: getBackgroundTextColor(isGood),
                                    fontWeight: FontWeight.w300,
                                    height: 1.2,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2),
                              ),
                              Text(
                                '${widget.waqiData.iaqi.pm10.floor()}%',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                    fontSize: 22,
                                    height: 1.2,
                                    color: getBackgroundTextColor(isGood),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                ),
                Text(
                  'Wybrana stacja pomiarowa',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: getBackgroundTextColor(isGood),
                      fontSize: 12,
                      height: 1.2,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                ),
                Text(
                  widget.waqiData.place,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: getBackgroundTextColor(isGood),
                      fontSize: 14,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 68),
                ),
              ],
            ),
          ),
          Positioned(
            left: 8,
            right: 0,
            top: (MediaQuery.of(context).size.width) / 2,
            // top: 60,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Stack(
                children: [
                  ClipRect(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: getDangerValueBottom(isGood)),
                    // child: getDangerValueTop(isGood)),
                  ),
                  ClipRect(
                    child: Align(
                        alignment: Alignment.topLeft,
                        heightFactor: 1 -
                            (widget.waqiData.airQualityIndex.floorToDouble() /
                                100),
                        child: getDangerValueTop(isGood)),
                    // child: getDangerValueBottom(isGood)),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(padding: EdgeInsets.only(top: 62)),
                  Divider(
                    height: 10,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                    color: getBackgroundTextColor(isGood),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: getAdviceImage(isGood),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                          ),
                          Text(
                            advice,
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                color: getBackgroundTextColor(isGood),
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                  )
                ],
              ),
            ),
          ),
          SlidingUpPanel(
            controller: _panelc,
            minHeight: 0,
            maxHeight: 360,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            panel: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                      ),
                      Text(
                        "Indeks CAQI",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(
                        "Indeks CAQI (ang. Common Air Quality Index) pozwala przedstawić sytuację w Europiie w porównywalny i łatwy do zrozumienia sposób. Wartość indeksu jest prezentowana w postaci jednej liczby. Skala ma rozpietość od 0 do wartości powyżej 100 i powyżej bardzo zanieczyszone. Im wyższa wartość wskażnika, tym większe ryzyko złego wpływu na zdrowie i sampoczucie.",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14),
                      ),
                      Text(
                        "Pył zawieszony PM2,5 i PM10",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(
                        "Pyły zawieszone to mieszanina bardzo małych cząstek. PM10 to wszystkie pyły mniejsze niz 10μm, natomiast w przypadku  PM2,5 nie większe niż 2,5μm. Zanieczyszczenia pyłowe mają zdolność do adsorpcji swojej powierzchni innych, bardzo szkodliwych związków chemicznych: dioksyn, furanów, metali ciężkich, czy benzo(a)pirenu - najbardziej toksycznego skłądnika smogu.",
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
                Positioned(

                    right: 0,
                    top: 0,
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            color: Colors.black,
                            height: 1.2,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                          size:30
                        ),
                        onPressed: () {
                          _panelc.close();
                        },
                      ),
                    ))
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
