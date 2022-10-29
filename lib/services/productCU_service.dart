import 'package:cvs_information/models/productCU.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductCUService {
  Map<String, String> headers = {
    "Authorization":
        "KakaoAK 550709688e2b0a1c0a77c8c8d43e8868", // Kakao REST API
  };

  Future<List<ProductCU>> getProducts() async {
    //http api 요청

    // 임시 테스트
    var response = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/search/category.json?category_group_code=CS2&x=127.0118979&y=36.9494054&sort=distance'),
        headers: headers);
    var json = convert.jsonDecode(response.body); // json -> 다트 변환
    var jsonResults = json['documents'] as List; // 내용을 리스트로 변환
    return jsonResults
        .map((productCU) => ProductCU.fromJson(productCU))
        .toList();
  }
}
