import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/product_detail.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  // final Product product;
  final Products? product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var productDetail;
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var item = await APIService.getProductById(widget.product!.id);
    setState(() {
      productDetail = item;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () => 
            Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                  ),
                  child: Hero(
                    tag: widget.product!.id.toString(),
                    child: Image.network(Uri.https(Config.apiURL, widget.product!.productImage!).toString()),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product!.name.length > 15 ? widget.product!.name.substring(0, 28) + "..." : widget.product!.name,
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Utilities.formatCurrency(widget.product!.price),
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor,
                    ),
                  ),
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(50),
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  //     height: getProportionateScreenWidth(28),
                  //     width: getProportionateScreenWidth(28),
                  //     decoration: BoxDecoration(
                  //       color: widget.product.isFavourite
                  //           ? kPrimaryColor.withOpacity(0.15)
                  //           : kSecondaryColor.withOpacity(0.1),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: SvgPicture.asset(
                  //       "assets/icons/Heart Icon_2.svg",
                  //       color: widget.product.isFavourite
                  //           ? Color(0xFFFF4848)
                  //           : Color(0xFFDBDEE4),
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
