import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:flutter/material.dart';

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
  // var productDetail;
  // List<Products>? listProductFavorite = [];


  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // fetchData() async {
  //   var item = await APIService.getProductById(widget.product!.id);
  //   var productFavorite = await APIService.getAllFavoriteProduct();
  //   setState(() {
  //     productDetail = item;
  //     listProductFavorite = productFavorite;
  //   });
  // }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(widget.width),
        child: GestureDetector(
          onTap: () => 
            Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: widget.product!)),
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
                    child: Image.network(widget.product!.productImage!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product!.name,
                style: const TextStyle(color: textColorList, fontSize: textSizeList),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Utilities.formatCurrency(widget.product!.price),
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(textSizeCost),
                      fontWeight: FontWeight.w500,
                      color: textColorCost,
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
                  // InkWell(
                  //   borderRadius: BorderRadius.circular(50),
                  //   onTap: () async {
                  //     var loginDetails = await SharedService.loginDetails();
                  //     FavoriteRequestModel model = FavoriteRequestModel(
                  //       token: loginDetails!.resultObj!,
                  //       productId: widget.product!.id
                  //     );                    
                  //     listProductFavorite!.any((element) => element.id == widget.product!.id) ? APIService.DeleteFavorite(model).then((response) async {
                  //       if (response.isSuccessed == true) {
                  //         APIService.getAllFavoriteProduct().then((response) async {
                  //           setState(() {
                  //             listProductFavorite = response;
                  //           });
                  //         });
                  //       }
                  //       }) : APIService.AddFavorite(model).then((response) async {
                  //       if (response.isSuccessed == true) {
                  //         APIService.getAllFavoriteProduct().then((response) async {
                  //           setState(() {
                  //             listProductFavorite = response;
                  //           });
                  //         });
                  //       }
                  //     });
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                  //     height: getProportionateScreenWidth(28),
                  //     width: getProportionateScreenWidth(28),
                  //     decoration: BoxDecoration(
                  //       color: kPrimaryColor.withOpacity(0.15),
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: SvgPicture.asset(
                  //       "assets/icons/Heart Icon_2.svg",
                  //       color: listProductFavorite!.any((element) => element.id == widget.product!.id) ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
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
