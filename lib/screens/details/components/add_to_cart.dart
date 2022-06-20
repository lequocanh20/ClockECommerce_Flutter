import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/items.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddProductToCart extends StatefulWidget {
  Items items;
  AddProductToCart({required this.items});

  @override
  _AddProductToCartState createState() => _AddProductToCartState();
}

class _AddProductToCartState extends State<AddProductToCart> {
  CollectionReference carts = FirebaseFirestore.instance.collection('Carts');
  List<Cart> listCart = [];
  
  @override
  void initState() {
    super.initState();
    fetchCart();
  }

  fetchCart() async {
    await carts.get().then((value) {
      for (var doc in value.docs) {
        if(doc.get('UserId') == FirebaseAuth.instance.currentUser!.uid) {
          setState(() {
            listCart.add(Cart(productId: doc.get('ProductId'), userId: doc.get('UserId'), quantity: doc.get('Quantity')));
          });
        }       
      }
    });
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
              Future<void> deleteProductInCart(id) {
                // print("User Deleted $id");
                return carts
                    .doc(id)
                    .delete()
                    .then((value) => print('Cart Deleted'))
                    .catchError((error) => print('Failed to Delete Cart: $error'));
              }
              Future<void> addProductIntoCart(Products product, String userId, int quantity) {
                final data = {
                  "UserId": userId,
                  "ProductId": product.id,
                  "OriginPrice": product.originPrice,
                  "Price": product.price,
                  "CategoryId": product.categoryId,
                  "Stock": product.stock,
                  "DateCreated": product.dateCreated,
                  "Name": product.name,
                  "Description": product.description,
                  "ProductImage": product.productImage,
                  "Quantity": quantity
                };
                  // print("User Deleted $id");
                  return carts
                      .doc(product.id + userId)
                      .set(data)
                      .then((value) => print('Product Added Into Cart'))
                      .catchError((error) => print('Failed to Add Product Into Cart: $error'));
              }
              if (listCart.any((e) => e.productId! + e.userId! == widget.items.products!.id + FirebaseAuth.instance.currentUser!.uid)) {
                // deleteProductInCart(widget.items.products!.id + FirebaseAuth.instance.currentUser!.uid).then((value) async {
                //   setState(() {
                //     listCart.removeWhere((element) => element.productId == widget.items.products!.id && element.userId == FirebaseAuth.instance.currentUser!.uid);
                //   });
                // });
                Fluttertoast.showToast(
                  msg: "Bạn đã thêm sản phẩm này từ trước. Vui lòng kiểm tra lại giỏ hàng.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
                );  
              } else {
                addProductIntoCart(widget.items.products!, FirebaseAuth.instance.currentUser!.uid, widget.items.quantity!).then((value) async {
                  carts.get().then((value) {
                    for (var doc in value.docs) {
                      setState(() {
                        listCart.add(Cart(productId: doc.get('ProductId'), userId: doc.get('UserId'), quantity: doc.get('Quantity')));
                      });       
                    }
                  });
                  Fluttertoast.showToast(
                    msg: "Đã thêm vào giỏ",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                });               
              }
                // Cart cart = Cart();
                // cart.addProductToCart(widget.items);
                // print(cart.getCart().length.toString());              
            }
      },
    );
  }
}
