import 'package:cvs_information/Screens/main_page.dart';
import 'package:cvs_information/Screens/onboarding_page.dart';
import 'package:cvs_information/services/event_service.dart';
import 'package:cvs_information/services/geolocator_service.dart';
import 'package:cvs_information/services/places_service.dart';
import 'package:cvs_information/services/productAll_service.dart';

import 'package:flutter/material.dart';
import 'package:cvs_information/color_schemes.g.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/place.dart';

bool? initScreen; // onboarding page 본적 있는지 유무 판단
Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // main 메소드에서 비동기 메소드 사용시 반드시 추가해야하는 한줄
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getBool('initScreen'); // 로드
  await preferences.setBool('initScreen', true); // 세이브

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final locatorService = GeoLocatorService();
  final placesService = PlacesService();
  final productAllService = ProductAllService();
  final eventService = EventService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => productAllService.getProducts(),
          initialData: null,
        ),
        FutureProvider(
          create: (context) => eventService.getEvents(),
          initialData: null,
        ),
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
        debugShowCheckedModeBanner: false,
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
        initialRoute:
            initScreen == false || initScreen == null ? 'onboard' : 'main',
        routes: {
          'main': (context) => const MainPage(),
          'onboard': (context) => const OnBoardingPage(),
        },
      ),
    );
  }
}
