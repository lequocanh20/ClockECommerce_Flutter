// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
    Products({
        required this.id,
        required this.originPrice,
        required this.price,
        required this.categoryId,
        required this.stock,
        required this.dateCreated,
        required this.name,
        required this.description,
        this.productImage,
        this.rating,
        this.reviews,
    });

    String id;
    double originPrice;
    double price;
    String categoryId;
    int stock;
    DateTime dateCreated;
    String name;
    String description;
    String? productImage;
    double? rating;
    dynamic reviews;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        originPrice: json["originPrice"],
        price: json["price"],
        categoryId: json["categoryId"],
        stock: json["stock"],
        dateCreated: DateTime.parse(json["dateCreated"]),
        name: json["name"],
        description: json["description"],
        productImage: json["productImage"],
        rating: json["rating"],
        reviews: json["reviews"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "originPrice": originPrice,
        "price": price,
        "categoryId": categoryId,
        "stock": stock,
        "dateCreated": dateCreated.toIso8601String(),
        "name": name,
        "description": description,
        "productImage": productImage,
        "rating": rating,
        "reviews": reviews,
    };
}