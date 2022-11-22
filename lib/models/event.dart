class Event {
  final String name; // 이름
  final String imageURL; // 이미지 링크
  final String company; // 회사

  Event({required this.name, required this.imageURL, required this.company});

  Event.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        imageURL = parsedJson['imgUrl'],
        company = parsedJson['company'];
}
