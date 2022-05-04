import 'dart:convert';

LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(json.decode(str));
class LoginResponseModel {
  LoginResponseModel({
    this.validationErrors,
    required this.isSuccessed,
    this.message,
    this.resultObj,
  });
  late final String? validationErrors;
  late final bool isSuccessed;
  late final String? message;
  late final String? resultObj;
  
  LoginResponseModel.fromJson(Map<String, dynamic> json){
    validationErrors = json['validationErrors'];
    isSuccessed = json['isSuccessed'];
    message = json['message'];
    resultObj = json['resultObj'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['validationErrors'] = validationErrors;
    _data['isSuccessed'] = isSuccessed;
    _data['message'] = message;
    _data['resultObj'] = resultObj;
    return _data;
  }
}