import 'dart:convert';

FavoriteResponseModel favoriteResponseModelFromJson(String str) => FavoriteResponseModel.fromJson(json.decode(str));

String favoriteResponseModelToJson(FavoriteResponseModel data) => json.encode(data.toJson());

class FavoriteResponseModel {
    FavoriteResponseModel({
        required this.isSuccessed,
        this.message,
        required this.resultObj,
    });

    bool isSuccessed;
    String? message;
    bool resultObj;

    factory FavoriteResponseModel.fromJson(Map<String, dynamic> json) => FavoriteResponseModel(
        isSuccessed: json["isSuccessed"],
        message: json["message"],
        resultObj: json["resultObj"],
    );

    Map<String, dynamic> toJson() => {
        "isSuccessed": isSuccessed,
        "message": message,
        "resultObj": resultObj,
    };
}