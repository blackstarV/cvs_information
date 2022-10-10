import 'package:cvs_information/models/geometry.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name; // 이름
  final dynamic rating; // 평점
  final dynamic userRatingCount; // 리뷰 개수
  final String vicinity; // 주소
  final Geometry geometry; // 위도, 경도
  final String place_id; // place 고유 id 값
  final BitmapDescriptor icon;

  Place(
      {required this.geometry,
      required this.name,
      required this.rating,
      required this.userRatingCount,
      required this.vicinity,
      required this.place_id,
      required this.icon});

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? parsedJson['rating'].toDouble()
            : 0.0, // rating이 존재하지 않는 편의점도 있어서 null
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total'].toDouble()
            : 0.0, // user_ratings_total이 존재하지 않는 편의점도 있어서 null
        vicinity =
            parsedJson['vicinity'].replaceAll(RegExp(r'KR'), ''), // 주소지에 KR 삭제
        geometry = Geometry.fromJson(parsedJson['geometry']),
        place_id = parsedJson['place_id'],
        icon = (parsedJson['name'].contains('CU') ||
                parsedJson['name'].contains('cu') ||
                parsedJson['name'].contains('씨유'))
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
            : (parsedJson['name'].contains('GS') ||
                    parsedJson['name'].contains('gs') ||
                    parsedJson['name'].contains('지에스'))
                ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan)
                : (parsedJson['name'].contains('세븐') ||
                        parsedJson['name'].contains('seven'))
                    ? BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen)
                    : (parsedJson['name'].contains('이마트') ||
                            parsedJson['name'].contains('이마트') ||
                            parsedJson['name'].contains('emart') ||
                            parsedJson['name'].contains('Emart') ||
                            parsedJson['name'].contains('EMART'))
                        ? BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueOrange)
                        : (parsedJson['name'].contains('미니') ||
                                parsedJson['name'].contains('미니스톱') ||
                                parsedJson['name'].contains('ministop'))
                            ? BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueYellow)
                            : BitmapDescriptor.defaultMarker;
}
