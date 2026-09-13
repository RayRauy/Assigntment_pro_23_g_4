class UserModel {
  const UserModel({
    required this.username,
    required this.nickName,
    required this.password,
  });

  final String username;
  final String nickName;
  final String password;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'nickName': nickName,
      'password': password,
    };
  }
}