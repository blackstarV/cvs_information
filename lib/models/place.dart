import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name; // 이름
  final String address_name; // 주소
  final double lat; // 위도
  final double lng; // 경도
  final String place_url; // place 고유 id 값
  final BitmapDescriptor icon;

  Place(
      {required this.name,
      required this.address_name,
      required this.lat,
      required this.lng,
      required this.place_url,
      required this.icon});

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['place_name'],
        address_name = parsedJson['address_name'],
        lat = double.parse(parsedJson['y']),
        lng = double.parse(parsedJson['x']),
        place_url = parsedJson['place_url'].replaceAll('http', 'https'),
        icon = (parsedJson['category_name'].contains('CU'))
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
            : (parsedJson['category_name'].contains('GS25'))
                ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan)
                : (parsedJson['category_name'].contains('세븐일레븐'))
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)
                    : (parsedJson['category_name'].contains('이마트24'))
                        ? BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueOrange)
                        : (parsedJson['category_name'].contains('미니스톱'))
                            ? BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueYellow)
                            : BitmapDescriptor.defaultMarker;
}
