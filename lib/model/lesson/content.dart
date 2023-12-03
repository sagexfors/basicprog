class Content {
  final String type;
  final String? text;
  final String? code;
  final List<dynamic>? table;

  Content({
    required this.type,
    this.text,
    this.code,
    this.table,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'text') {
      return Content(type: json['type'], text: json['text']);
    } else if (json['type'] == 'code') {
      return Content(type: json['type'], code: json['code']);
    } else if (json['type'] == 'table') {
      return Content(type: json['type'], table: json['table']);
    } else {
      throw Exception('Invalid content type');
    }
  }
}
