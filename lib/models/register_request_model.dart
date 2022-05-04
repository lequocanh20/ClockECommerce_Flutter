class RegisterRequestModel {
  RegisterRequestModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.userName,
    required this.password,
    required this.confirmPassword,
  });
  late final String name;
  late final String email;
  late final String address;
  late final String phoneNumber;
  late final String userName;
  late final String password;
  late final String confirmPassword;
  
  RegisterRequestModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['address'] = address;
    _data['phoneNumber'] = phoneNumber;
    _data['userName'] = userName;
    _data['password'] = password;
    _data['confirmPassword'] = confirmPassword;
    return _data;
  }
}