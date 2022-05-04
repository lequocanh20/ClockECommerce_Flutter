import 'dart:convert';

UserViewModel userViewModelJson(String str) => UserViewModel.fromJson(json.decode(str));
class UserViewModel {
  UserViewModel({
    required this.isSuccessed,
    this.message,
    required this.resultObj,
  });
  late final bool isSuccessed;
  late final String? message;
  late final ResultObj resultObj;
  
  UserViewModel.fromJson(Map<String, dynamic> json){
    isSuccessed = json['isSuccessed'];
    message = json['message'];
    resultObj = ResultObj.fromJson(json['resultObj']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isSuccessed'] = isSuccessed;
    _data['message'] = message;
    _data['resultObj'] = resultObj.toJson();
    return _data;
  }
}

class ResultObj {
  ResultObj({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.userName,
    required this.email,
    required this.address,
    required this.roles,
  });
  late final String id;
  late final String name;
  late final String phoneNumber;
  late final String userName;
  late final String email;
  late final String address;
  late final String roles;
  
  ResultObj.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    email = json['email'];
    address = json['address'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['phoneNumber'] = phoneNumber;
    _data['userName'] = userName;
    _data['email'] = email;
    _data['address'] = address;
    _data['roles'] = roles;
    return _data;
  }
}