class tagObj {
  final int id;
  final String tag_name;

  tagObj._({
    this.id,
    this.tag_name,
  });

  factory tagObj.fromJson(Map<String, dynamic> json) {
    return new tagObj._(
      id: json['id'],
      tag_name: json['tag_name'],
    );
  }
}
