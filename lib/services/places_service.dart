import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyA1gLhWNZQZt3Fq2_ppqMYOX6kg69Id51c';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${lat},${lng}&language=ko&type=convenience_store&rankby=distance&key=${key}'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
