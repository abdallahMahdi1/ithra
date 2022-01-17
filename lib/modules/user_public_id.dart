class Userid {
  User? user;

  Userid({this.user});

  Userid.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

}

class User {
  String? publicId;

  User({this.publicId});

  User.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
  }


}