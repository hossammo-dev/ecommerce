class UserModel {
  String? uid;
  String? username;
  String? email;
  String? phoneNumber;

  UserModel({
    this.uid,
    this.username,
    this.email,
    this.phoneNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phone-number'];
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'phone-number': phoneNumber,
      };
}
