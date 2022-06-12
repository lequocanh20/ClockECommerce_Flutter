import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/components/rounded_icon_btn.dart';
import 'package:clockecommerce/models/items.dart';
import 'package:clockecommerce/models/product_detail.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/components/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  // final Products product;

  final Products product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int quantity = 1;
  void _upCounter() {
    setState(() {
      quantity++;
    });
  }
  void _downCounter() {
    setState(() {
      quantity > 1 ? quantity-- : quantity;
    });
  }
  @override
  void initState() {
    super.initState();
    quantity = 1;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: widget.product,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Utilities.formatCurrency(widget.product.price), style: TextStyle(color: Colors.red, fontSize: 25),),
                          SizedBox(height: getProportionateScreenWidth(10)), 
                          Row(
                            children: [
                              // ...List.generate(
                              //   widget.product.colors.length,
                              //   (index) => ColorDot(
                              //     color: widget.product.colors[index],
                              //     isSelected: index == selectedColor,
                              //   ),
                              // ),
                              // Spacer(),
                              SizedBox(height: getProportionateScreenWidth(50)),
                              RoundedIconBtn(
                                icon: Icons.remove,
                                press: () {
                                  _downCounter();
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                              Text(quantity.toString(), style: TextStyle(fontSize: 18),),
                              SizedBox(width: getProportionateScreenWidth(20)),
                              RoundedIconBtn(
                                icon: Icons.add,
                                showShadow: true,
                                press: () {
                                  _upCounter();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth! * 0.15,
                          right: SizeConfig.screenWidth! * 0.15,
                          bottom: getProportionateScreenWidth(5),
                          top: getProportionateScreenWidth(0),
                        ),
                        child: AddProductToCart(items: Items(products: widget.product, quantity: quantity)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}