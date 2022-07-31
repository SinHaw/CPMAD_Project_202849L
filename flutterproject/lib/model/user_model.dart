class userModel {
  String user_id;
  String email;
  String name;

  userModel({this.user_id, this.email, this.name});

//data from server
  factory userModel.fromMap(map) {
    return userModel(
        user_id: map['user_id'], email: map['email'], name: map['name']);
  }
  //send to server
  Map<String, dynamic> toMap() {
    return {'user_id': user_id, 'email': email, 'name': name};
  }
}
