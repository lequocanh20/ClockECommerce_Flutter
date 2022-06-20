import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/items.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/cart/components/cart_card.dart';
import 'package:clockecommerce/screens/cart/components/check_out_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // List<Items> cartdetails = Cart().getCart();
  // double sum = 0.0;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   cartdetails.forEach((item) { sum = sum + item.products!.price * item.quantity!; });
  // }
  CollectionReference carts = FirebaseFirestore.instance.collection('Carts');
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  List<Cart> cartdetails = [];
  List<Products> listProducts = []; 
  double sum = 0.0;

  @override
  void initState() {
    super.initState();
    fetchDataCart();
    fetchDataProduct();
  }

  fetchDataCart() async {
    await carts.get().then((value) {
      for (var doc in value.docs) {
        if(doc.get('UserId') == FirebaseAuth.instance.currentUser!.uid) {
          setState(() {
            cartdetails.add(Cart(productId: doc.get('ProductId'), name: doc.get("Name"), price: doc.get("Price"), productImage: doc.get("ProductImage"), userId: doc.get('UserId'), quantity: doc.get('Quantity')));
          });             
        }          
      }
      // test = listProductFavorite.indexOf()
    });
    for (var item in cartdetails) { 
      setState(() {
        sum = sum + item.price! * item.quantity!;
      });     
    }
  }

  fetchDataProduct() async {
    await products.get().then((value) {
      for (var doc in value.docs) {
        listProducts.add(Products(id: doc.get('Id'), originPrice: (doc.get('OriginPrice') as int).toDouble(), 
          price: (doc.get('Price') as int).toDouble(), categoryId: doc.get('CategoryId'), stock: (doc.get('Stock') as int).toInt(), 
          dateCreated: DateTime.parse(doc.get('DateCreated')), name: doc.get('Name'), description: doc.get('Description'),
          productImage: doc.get('ProductImage')));  
      }
      // test = listProductFavorite.indexOf()
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> deleteProductInCart(id) {
      // print("User Deleted $id");
      return carts
        .doc(id)
        .delete()
        .then((value) => print('Cart Deleted'))
        .catchError((error) => print('Failed to Delete Cart: $error'));
    }
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
      padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
          itemCount: cartdetails.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(cartdetails[index].productId.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  deleteProductInCart(cartdetails[index].productId! + FirebaseAuth.instance.currentUser!.uid).then((value) async {
                    setState(() {
                      cartdetails.removeWhere((element) => element.productId == cartdetails[index].productId && element.userId == FirebaseAuth.instance.currentUser!.uid);
                    });
                  });
                  cartdetails.removeAt(index);
                  sum = 0.0;
                  cartdetails.forEach((item) { 
                    for (var i = 0; i < listProducts.length; i++) {
                      var element = listProducts.elementAt(i);
                      if (element.id == item.productId) {
                        sum = sum + element.price * item.quantity!; 
                      }
                    }     
                  });
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(items: cartdetails[index]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(sum: sum, cartDetails: cartdetails),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          const Text(
            "Giỏ hàng của bạn",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${cartdetails.length} mặt hàng",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
      backgroundColor: kPrimaryColor,
    );
  }
}



    
