import 'package:cvs_information/Screens/onboardingpage.dart';
import 'package:cvs_information/services/geolocator_service.dart';
import 'package:cvs_information/services/places_service.dart';

import 'package:flutter/material.dart';
import 'package:cvs_information/color_schemes.g.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'models/place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
            create: (context) => locatorService.getLocation(),
            initialData: null),
        ProxyProvider<Position?, Future<List<Place>?>?>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        themeMode: ThemeMode.system, // 테마모드가 시스템설정을 따라가게 한다.
        home: const OnBoardingPage(),
      ),
    );
  }
}
