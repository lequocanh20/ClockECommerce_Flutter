import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/favorite_request_model.dart';
import 'package:clockecommerce/models/product_detail.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/details/components/body.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:clockecommerce/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List<Products>? listProductFavorite = [];
  @override
  void initState() {
    super.initState();
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
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: Row(
              children: [
                SizedBox(
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    onPressed: () async => Navigator.pop(context, listProductFavorite),
                    child: SvgPicture.asset(
                      "assets/icons/Back ICon.svg",
                      height: 15,
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () async {
                      var loginDetails = await SharedService.loginDetails();
                      FavoriteRequestModel model = FavoriteRequestModel(
                        token: loginDetails!.resultObj!,
                        productId: agrs.product.id
                      );                    
                      listProductFavorite!.any((element) => element.id == agrs.product.id) ? APIService.DeleteFavorite(model).then((response) async {
                        if (response.isSuccessed == true) {
                          APIService.getAllFavoriteProduct().then((response) async {
                            setState(() {
                              listProductFavorite = response;
                            });
                          });
                        }
                        }) : APIService.AddFavorite(model).then((response) async {
                        if (response.isSuccessed == true) {
                          APIService.getAllFavoriteProduct().then((response) async {
                            setState(() {
                              listProductFavorite = response;
                            });
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: listProductFavorite!.any((element) => element.id == agrs.product.id) ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  // final Products product;
  final ProductDetail product;


  ProductDetailsArguments({required this.product});
  
}
