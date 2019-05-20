class User {
  int id;
  String name;
  String email;
  String image;
  String followers;
  String following;
  String posts;

  User(this.id, this.email, this.posts, this.name, this.image, this.followers,
      this.following);

  User._(
      {this.id,
      this.email,
      this.posts,
      this.name,
      this.image,
      this.followers,
      this.following});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User._(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      followers: json['followers'],
      following: json['following'],
      posts: json['posts'],
    );
  }

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data['id'] = user.id;
    data['name'] = user.name;
    data['email'] = user.email;
    data['followers'] = user.followers;
    data['following'] = user.following;
    data['posts'] = user.posts;

    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.id = mapData['id'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.image = mapData['image'];
    this.followers = mapData['followers'];
    this.following = mapData['following'];
    this.posts = mapData['posts'];
  }
}
