class userObj {
  final int id;
  final String name;
  final String image;
  final String followers;
  final String following;

  userObj._({this.id, this.name, this.image, this.followers, this.following});

  factory userObj.fromJson(Map<String, dynamic> json) {
    return new userObj._(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}
