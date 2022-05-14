import 'package:clockecommerce/components/product_card.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/product/product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'section_title.dart';

class LatestProducts extends StatefulWidget {
  const LatestProducts({Key? key}) : super(key: key);

  @override
  State<LatestProducts> createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  final Stream<QuerySnapshot> _productStream = 
    FirebaseFirestore.instance.collection('Products').snapshots();
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Sản phẩm mới nhất", press: () {
            Navigator.pushNamed(context, ProductScreen.routeName);
          }),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        StreamBuilder<QuerySnapshot>(
          stream: _productStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            final List<Products> storedocs = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              storedocs.add(Products(id: (a['Id'] as int).toInt(), name: a['Name'], price: (a['Price'] as int).toDouble(), originPrice: (a['OriginPrice'] as int).toDouble(), stock: (a['Stock'] as int).toInt(), dateCreated: (a['DateCreated'] as Timestamp).toDate(), categoryId: a['CategoryId'], description: a['Description'], productImage: a['ProductImage']));
            });
            // storedocs.sort((a,b) => a.dateCreated.compareTo(b.dateCreated));
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    storedocs.length,
                    (index) {                     
                      return ProductCard(product: storedocs[index]); // here by default width and height is 0
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}



// class GetBodyFeaturedProduct extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Products>?> products = ref.watch(productFeaturedStateFuture);
//     return products.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('${err.toString()}')),
//       data: (products) {
//         return SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               ...List.generate(
//                 products!.length,
//                 (index) {
//                   return ProductCard(product: products[index]); // here by default width and height is 0
//                 },
//               ),
//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }
