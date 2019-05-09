class imageObj {
  final String title;
  final String thumbnailUrl;

  imageObj._({this.title, this.thumbnailUrl});

  factory imageObj.fromJson(Map<String, dynamic> json) {
    return new imageObj._(
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}
