import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  // 위치 받아오기
  Future<Position> getLocation() async {
    /** 사용자에게 위치정보를 허락할 건지 물어본다. */
    LocationPermission permission = await Geolocator.requestPermission();

    /** 현재위치(정확도: 높음)를 받아온다. */
    final geolocator = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return geolocator;
  }

  // 거리 받아오기
  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
