// ignore_for_file: unnecessary_brace_in_string_interps

import '../models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyA1gLhWNZQZt3Fq2_ppqMYOX6kg69Id51c';
  Map<String, String> headers = {
    "Authorization":
        "KakaoAK 550709688e2b0a1c0a77c8c8d43e8868" // Kakao REST API
  };

  Future<List<Place>> getPlaces(double lat, double lng) async {
    //http api 요청
    var response = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/search/category.json?category_group_code=CS2&x=${lng}&y=${lat}&sort=distance'),
        headers: headers);
    var json = convert.jsonDecode(response.body); // json -> 다트 변환
    var jsonResults = json['documents'] as List; // documents 속 내용을 리스트로 변환
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
