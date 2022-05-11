import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/product_detail.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key, required this.product, this.pressOnSeeMore}) : super(key: key);

  // final Products product;
  final ProductDetail product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  List<Products>? listProductFavorite = [];
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.product.description.length > 70) {
      firstHalf = widget.product.description.substring(0, 70);
      secondHalf = widget.product.description.substring(70, widget.product.description.length);
    } else {
      firstHalf = widget.product.description;
      secondHalf = "";
    }
    fetchData();
  }

  fetchData() async {
    var productFavorite = await APIService.getAllFavoriteProduct();
    setState(() {
      listProductFavorite = productFavorite;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            children: [
              Flexible(child: Text(
                widget.product.name,
                style: Theme.of(context).textTheme.headline6,
              )),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.product.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5),
                      SvgPicture.asset("assets/icons/Star Icon.svg"),
                    ],
                  ),
                )
            ],
          ),
        ),
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Container(
        //     padding: EdgeInsets.all(getProportionateScreenWidth(15)),
        //     width: getProportionateScreenWidth(64),
        //     decoration: BoxDecoration(
        //       color:
        //           listProductFavorite!.any((element) => element.id == widget.product.id) ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
        //       borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         bottomLeft: Radius.circular(20),
        //       ),
        //     ),
        //     child: SvgPicture.asset(
        //       "assets/icons/Heart Icon_2.svg",
        //       color:
        //           listProductFavorite!.any((element) => element.id == widget.product.id) ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
        //       height: getProportionateScreenWidth(16),
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: secondHalf.isEmpty ? Text(firstHalf) : 
          Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                )
              ]
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 5,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
            child: Row(
              children: [
                Text(
                  flag ? "Xem chi tiết" : "Rút gọn",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class SeeMore extends StatefulWidget {
  String text;
  SeeMore({Key? key, required this.text}) : super(key: key);

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {
  late Products product;
  late String firstHalf;
  late String secondHalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > 70) {
      firstHalf = widget.text.substring(0, 70);
      secondHalf = widget.text.substring(70, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              firstHalf,
            )
          : Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "show more" : "show less",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}