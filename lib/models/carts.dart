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
}