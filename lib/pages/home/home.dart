import 'package:flutter/material.dart';
import 'package:waether/pages/weather/weather.dart';
import 'package:waether/pages/weather/air.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.weather});

  final Weather weather;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      Air(),
      WeatherScreen(
        weather: widget.weather,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black38,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 30,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/house.png'),
                  label: 'Powietrze',
                  activeIcon: Image.asset('assets/house-checked.png'),
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/cloud.png'),
                  label: 'Pogoda',
                  activeIcon: Image.asset('assets/cloud-checked.png'),
                ),
              ]),
          body: IndexedStack(index: currentIndex, children: screens),
        ));
  }
}
