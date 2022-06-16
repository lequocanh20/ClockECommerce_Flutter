import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/favorites.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/details/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";

  DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Stream<QuerySnapshot> _favoriteStream = 
    FirebaseFirestore.instance.collection('Favorites').snapshots();
  CollectionReference favorites = FirebaseFirestore.instance.collection('Favorites');
  List<Favorites> listProductFavorite = [];
  var test;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await favorites.get().then((value) {
      for (var doc in value.docs) {
        setState(() {
          listProductFavorite.add(Favorites(productId: doc.get('ProductId'), userId: doc.get('UserId')));
        });       
      }
      // test = listProductFavorite.indexOf()
    });
  }
  @override
  Widget build(BuildContext context) {
  Future<void> deleteProduct(id) {
      // print("User Deleted $id");
      return favorites
          .doc(id)
          .delete()
          .then((value) => print('Product Deleted'))
          .catchError((error) => print('Failed to Delete product: $error'));
  }
  Future<void> addProduct(String productId, String userId) {
    final data = <String, String>{
      "UserId": userId,
      "ProductId": productId,
    };
      // print("User Deleted $id");
      return favorites
          .doc(productId + userId)
          .set(data)
          .then((value) => print('Product Added'))
          .catchError((error) => print('Failed to Delete product: $error'));
  }
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
                    onPressed: () { Navigator.pop(context);},
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
                      // var loginDetails = await SharedService.loginDetails();
                      // FavoriteRequestModel model = FavoriteRequestModel(
                      //   token: loginDetails!.resultObj!,
                      //   productId: agrs.product.id
                      // );                    
                      // listProductFavorite!.any((element) => element.id == agrs.product.id) ? APIService.DeleteFavorite(model).then((response) async {
                      //   if (response.isSuccessed == true) {
                      //     APIService.getAllFavoriteProduct().then((response) async {
                      //       setState(() {
                      //         listProductFavorite = response;
                      //       });
                      //     });
                      //   }
                      //   }) : APIService.AddFavorite(model).then((response) async {
                      //   if (response.isSuccessed == true) {
                      //     APIService.getAllFavoriteProduct().then((response) async {
                      //       setState(() {
                      //         listProductFavorite = response;
                      //       });
                      //     });
                      //   }
                      // });
                      if (listProductFavorite.any((e) => e.productId + e.userId == agrs.product.id + FirebaseAuth.instance.currentUser!.uid)) {
                        deleteProduct(agrs.product.id + FirebaseAuth.instance.currentUser!.uid).then((value) async {
                          setState(() {
                            listProductFavorite.removeWhere((element) => element.productId == agrs.product.id && element.userId == FirebaseAuth.instance.currentUser!.uid);
                          });
                        });
                      } else {
                        addProduct(agrs.product.id, FirebaseAuth.instance.currentUser!.uid).then((value) async {
                          favorites.get().then((value) {
                              for (var doc in value.docs) {
                                setState(() {
                                  listProductFavorite.add(Favorites(productId: doc.get('ProductId'), userId: doc.get('UserId')));
                                });       
                              }
                          });
                        });
                      }
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
                        color: listProductFavorite.any((e) => e.productId + e.userId == agrs.product.id + FirebaseAuth.instance.currentUser!.uid) ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
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
  final Products product;


  ProductDetailsArguments({required this.product});
  
}
