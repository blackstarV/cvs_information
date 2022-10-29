class ProductEmart24 {
  final String name; // 이름
  final String event; // 행사 유형
  final int price; // 가격
  final String image; // 이미지 링크

  ProductEmart24(
      {required this.name,
      required this.event,
      required this.price,
      required this.image});

  ProductEmart24.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        event = parsedJson['event'],
        price = int.parse(parsedJson['price']),
        image = parsedJson['image'];
}
