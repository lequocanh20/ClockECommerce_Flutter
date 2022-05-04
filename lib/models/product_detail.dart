// To parse this JSON data, do
//
//     final produdtDetail = produdtDetailFromJson(jsonString);

import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

class ProductDetail {
    ProductDetail({
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

    int id;
    double originPrice;
    double price;
    int categoryId;
    int stock;
    DateTime dateCreated;
    String name;
    String description;
    String? productImage;
    double? rating;
    List<Review>? reviews;

    factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
        "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
    };
}

class Review {
    Review({
      required this.id,
      required this.userId,
      required this.userName,
      required this.productId,
      required this.rating,
      required this.comments,
      required this.publishedDate,
      required this.status,
    });

    int id;
    String userId;
    String userName;
    int productId;
    double rating;
    String comments;
    DateTime publishedDate;
    int status;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userId"],
        userName: json["userName"],
        productId: json["productId"],
        rating: json["rating"],
        comments: json["comments"],
        publishedDate: DateTime.parse(json["publishedDate"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "userName": userName,
        "productId": productId,
        "rating": rating,
        "comments": comments,
        "publishedDate": publishedDate.toIso8601String(),
        "status": status,
    };
}
