import 'package:cvs_information/models/geometry.dart';

class Place {
  final String name; // 이름
  final double rating; // 평점
  final int userRatingCount; // 리뷰 개수
  final String vicinity; // 주변 읍면동
  final Geometry geometry; // 위도, 경도

  Place(
      {required this.geometry,
      required this.name,
      required this.rating,
      required this.userRatingCount,
      required this.vicinity});

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating = (parsedJson['rating'] != null)
            ? parsedJson['rating'].toDouble()
            : null, // rating이 존재하지 않는 편의점도 있어서 null처리
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : null, // user_ratings_total이 존재하지 않는 편의점도 있어서 null처리
        vicinity = parsedJson['vicinity'],
        geometry = Geometry.fromJson(parsedJson['geometry']);
}
