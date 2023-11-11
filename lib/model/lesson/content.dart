class Content {
  final String type;
  final String? text;
  final String? code;
  final List<List<dynamic>>? table;

  Content({
    required this.type,
    this.text,
    this.code,
    this.table,
  });
}
