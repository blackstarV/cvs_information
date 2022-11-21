class ProductAll {
  final String name; // 이름
  final String type; // 행사 유형
  final int price; // 가격
  final String imageURL; // 이미지 링크
  final String company; // 회사
  final bool isFavorite = false; // 찜 기능

  ProductAll(
      {required this.name,
      required this.type,
      required this.price,
      required this.imageURL,
      required this.company});

  ProductAll.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        type = parsedJson['eventType'],
        price = parsedJson['price'],
        imageURL = parsedJson['imageURL'],
        company = parsedJson['company'];
}
