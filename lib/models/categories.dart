// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    Categories({
        required this.id,
        required this.name,
        this.imageCate,
    });

    String id;
    String name;
    String? imageCate;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        imageCate: json["imageCate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageCate": imageCate,
    };
}
