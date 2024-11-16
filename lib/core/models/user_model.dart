class UserModel {
  String? phoneNumber;
  String? fullName;
  String? email;
  String? password;
  String? gender;

  UserModel({
    this.phoneNumber,
    this.email,
    this.password,
    this.fullName,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'password': password,
      'gender':gender,
    };
  }
}
