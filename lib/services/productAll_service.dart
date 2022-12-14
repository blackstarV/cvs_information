import 'dart:convert';

import 'package:cvs_information/models/productAll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductAllService {
  Map<String, String> headers = {'': ''};

  Future<List<ProductAll>> getProducts() async {
    //http api 요청

    var response = await http.get(
        Uri.parse(
            'http://222.118.240.100:8000/cvsinfo/ProductInfo/?format=json'),
        headers: headers);
    var json =
        convert.jsonDecode(utf8.decode(response.bodyBytes)); // json -> 다트 변환
    var jsonResults = json as List; // 내용을 리스트로 변환
    return jsonResults
        .map((productAll) => ProductAll.fromJson(productAll))
        .toList();
  }
}
