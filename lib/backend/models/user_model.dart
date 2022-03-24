class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? nickname;

  UserModel(
      {this.uid, this.email, this.firstName, this.lastName, this.nickname});

  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        nickname: map['nickname']);
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'nickname': nickname
    };
  }
}
