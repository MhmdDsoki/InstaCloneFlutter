class postObj {
  final int id;
  final String creator_name;
  final String creator_image;
  final String post_image;
  final List<String> liked_by;
  final String post_time;

  postObj._({
    this.id,
    this.creator_name,
    this.creator_image,
    this.post_image,
    this.liked_by,
    this.post_time,
  });

  factory postObj.fromJson(Map<String, dynamic> json) {
    return new postObj._(
        id: json['id'],
        creator_name: json['creator_name'],
        creator_image: json['creator_image'],
        post_image: json['post_image'],
        post_time: json['post_time'],
        liked_by: (json['liked_by'] as List)
            .map((map) => "$map")
            .toList());
  }
}
