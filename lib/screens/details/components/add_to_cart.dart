import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/items.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductToCart extends StatefulWidget {
  Items items;
  AddProductToCart({required this.items});

  @override
  _AddProductToCartState createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultButton(
      text: "Thêm vào giỏ",
      press: () {
        if(widget.items.quantity == 0){
              Fluttertoast.showToast(
                msg: "Số lượng không thể bằng 0",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
            } else {
                Cart cart = Cart();
                cart.addProductToCart(widget.items);
                print(cart.getCart().length.toString());
                Fluttertoast.showToast(
                    msg: "Đã thêm vào giỏ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
            }
      },
    );
  }
}
