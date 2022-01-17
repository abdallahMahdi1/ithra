


class LoginAndRegisterModel {
  LoginAndRegisterModel({
    this.token,
    this.error,
    this.massage,
    this.publicId
  });

  String? publicId;
  String? token;
  String? error;
  String? massage;

  factory LoginAndRegisterModel.fromJson(Map<String, dynamic> json) => LoginAndRegisterModel(
    token: json["token"],
    error: json["error"],
    massage: json["massage"],
      publicId : json["public_id"]
  );

}
