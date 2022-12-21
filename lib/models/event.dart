import 'package:flutter/material.dart';

class Event {
  final String name; // 이름
  final String imageURL; // 이미지 링크
  final String company; // 회사
  final Image companyImage; //회사이미지

  Event({
    required this.name,
    required this.imageURL,
    required this.company,
    required this.companyImage,
  });

  Event.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        imageURL = parsedJson['imgUrl'],
        company = parsedJson['company'],
        companyImage = (parsedJson['company'] == 'CU')
            ? Image.asset('images/cu.png', width: 40)
            : (parsedJson['company'] == 'GS25')
                ? Image.asset('images/gs25.png', width: 40)
                : (parsedJson['company'] == '세븐일레븐')
                    ? Image.asset('images/seven_eleven.png', width: 40)
                    : (parsedJson['company'] == '이마트24')
                        ? Image.asset('images/emart24.png', width: 40)
                        : (parsedJson['company'] == '미니스톱')
                            ? Image.asset('images/ministop.png', width: 40)
                            : Image.asset('', width: 40);
}
