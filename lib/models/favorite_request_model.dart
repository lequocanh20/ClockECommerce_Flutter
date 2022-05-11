// To parse this JSON data, do
//
//     final favoriteRequestModel = favoriteRequestModelFromJson(jsonString);

import 'dart:convert';

FavoriteRequestModel favoriteRequestModelFromJson(String str) => FavoriteRequestModel.fromJson(json.decode(str));

String favoriteRequestModelToJson(FavoriteRequestModel data) => json.encode(data.toJson());

class FavoriteRequestModel {
    FavoriteRequestModel({
        required this.token,
        required this.productId,
    });

    String token;
    int productId;

    factory FavoriteRequestModel.fromJson(Map<String, dynamic> json) => FavoriteRequestModel(
        token: json["token"],
        productId: json["productId"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "productId": productId,
    };
}
