import 'package:cvs_information/Screens/homepage.dart';
import 'package:cvs_information/screens/mappage.dart';
import 'package:cvs_information/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = [
    const HomePage(),
    const MapPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      drawer: const NavigationDrawer(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.map), label: 'Map'),
        ],
      ),
    );
  }
}
