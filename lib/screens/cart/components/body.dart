import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/items.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/cart/components/cart_card.dart';
import 'package:clockecommerce/screens/cart/components/check_out_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Items> cartdetails = Cart().getCart();
  double sum = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartdetails.forEach((item) { sum = sum + item.products!.price * item.quantity!; });
  }

  @override
  Widget build(BuildContext context) {
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
              key: Key(cartdetails[index].products!.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  cartdetails.removeAt(index);
                  sum = 0.0;
                  cartdetails.forEach((item) { sum = sum + item.products!.price * item.quantity!; });
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
      bottomNavigationBar: CheckoutCard(sum: sum),
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
    );
  }
}



    
