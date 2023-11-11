class Lesson {
  String? _title;
  String? _description;
  List<Content>? _content;

  Lesson({String? title, String? description, List<Content>? content}) {
    if (title != null) {
      _title = title;
    }
    if (description != null) {
      _description = description;
    }
    if (content != null) {
      _content = content;
    }
  }

  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  List<Content>? get content => _content;
  set content(List<Content>? content) => _content = content;

  Lesson.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _description = json['description'];
    if (json['content'] != null) {
      _content = <Content>[];
      json['content'].forEach((v) {
        _content!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = _title;
    data['description'] = _description;
    if (_content != null) {
      data['content'] = _content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  String? _type;
  String? _text;
  String? _code;
  List<List<dynamic>>? table;

  Content(
      {String? type, String? text, String? code, List<List<dynamic>>? table,}) {
    if (type != null) {
      _type = type;
    }
    if (text != null) {
      _text = text;
    }
    if (code != null) {
      _code = code;
    }
    if (table != null) {
      this.table = table;
    }
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  String? get text => _text;
  set text(String? text) => _text = text;

  Content.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['text'] = _text;
    return data;
  }
}
