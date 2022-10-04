import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<Position> getLocation() async {
    /** 사용자에게 위치정보를 허락할 건지 물어본다. */
    LocationPermission permission = await Geolocator.requestPermission();

    /** 현재위치(정확도: 높음)를 받아온다. */
    final geolocator = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return geolocator;
  }
}
