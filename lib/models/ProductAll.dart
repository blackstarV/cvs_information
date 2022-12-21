import 'package:flutter/material.dart';

class ProductAll {
  final String name; // 이름
  final String type; // 행사 유형
  final Image typeImage; // 행사 유형 이미지
  final int price; // 가격
  final String imageURL; // 이미지 링크
  final String company; // 회사
  final Image companyImage; // 회사 이미지
  bool isFavorite = false; // 찜 기능

  ProductAll(
      {required this.name,
      required this.type,
      required this.typeImage,
      required this.price,
      required this.imageURL,
      required this.company,
      required this.companyImage});

  ProductAll.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        type = parsedJson['eventType'],
        typeImage = (parsedJson['eventType'] == '1+1')
            ? Image.asset('images/1+1.png', width: 30)
            : (parsedJson['eventType'] == '2+1')
                ? Image.asset('images/2+1.png', width: 30)
                : (parsedJson['eventType'] == '3+1')
                    ? Image.asset('images/3+1.png', width: 30)
                    : (parsedJson['eventType'] == '할인')
                        ? Image.asset('images/sale.png', width: 30)
                        : (parsedJson['eventType'] == '덤증정')
                            ? Image.asset('images/bonusgift.png', width: 30)
                            : Image.asset('images/sale.png', width: 30),
        price = parsedJson['price'],
        imageURL = parsedJson['imgURL'],
        company = parsedJson['company'],
        companyImage = (parsedJson['company'] == 'CU')
            ? Image.asset('images/cu.png', width: 30)
            : (parsedJson['company'] == 'GS25')
                ? Image.asset('images/gs25.png', width: 30)
                : (parsedJson['company'] == '7-ELEVEn')
                    ? Image.asset('images/seven_eleven.png', width: 30)
                    : (parsedJson['company'] == 'emart24')
                        ? Image.asset('images/emart24.png', width: 30)
                        : (parsedJson['company'] == 'MINISTOP')
                            ? Image.asset('images/ministop.png', width: 30)
                            : Image.asset('', width: 30);
}
