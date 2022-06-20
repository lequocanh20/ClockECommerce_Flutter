import 'package:clockecommerce/models/items.dart';

import 'products.dart';

class Cart {
  static List<Items> cart = [];
  void addProductToCart(Items item){
    cart.add(item);
  }

  List<Items> getCart(){
    return cart;
  }

  Cart ({
    this.productId,
    this.name,
    this.price,
    this.productImage,
    this.userId,
    this.quantity
  });
  String? productId;
  String? name;
  double? price;
  String? productImage;
  String? userId;
  int? quantity;
}