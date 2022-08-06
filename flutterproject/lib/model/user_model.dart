class userModel {
  String user_id;
  String email;
  String name;
  String imageUrl;

  userModel({this.user_id, this.email, this.name, this.imageUrl});

//data from server
  factory userModel.fromMap(map) {
    return userModel(
        user_id: map['user_id'],
        email: map['email'],
        name: map['name'],
        imageUrl: map['imageUrl']);
  }
  //send to server
  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'email': email,
      'imageUrl': imageUrl,
      'name': name
    };
  }
}
