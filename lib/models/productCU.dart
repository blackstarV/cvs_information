import 'package:flutter/cupertino.dart';

class ProductCU {
  final String name; // 이름
  final String event; // 행사 유형
  final int price; // 가격
  final String image; // 이미지 링크

  ProductCU(
      {required this.name,
      required this.event,
      required this.price,
      required this.image});

  ProductCU.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['address_name'],
        event = parsedJson['category_group_code'],
        price = int.parse(parsedJson['distance']),
        image = parsedJson['place_url'];
}
