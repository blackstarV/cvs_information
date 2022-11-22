import 'dart:convert';

import 'package:cvs_information/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class EventService {
  Map<String, String> headers = {'': ''};

  Future<List<Event>> getEvents() async {
    //http api 요청

    var response = await http.get(
        Uri.parse(
            'https://cvsinformation.herokuapp.com/cvsinfo/EventInfo/?format=json'),
        headers: headers);
    var json =
        convert.jsonDecode(utf8.decode(response.bodyBytes)); // json -> 다트 변환
    var jsonResults = json as List; // 내용을 리스트로 변환
    return jsonResults.map((event) => Event.fromJson(event)).toList();
  }
}
