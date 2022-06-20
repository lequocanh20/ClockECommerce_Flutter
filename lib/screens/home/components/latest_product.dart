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
              Map data = document.data() as Map<String, dynamic>;
              storedocs.add(Products(id: data['Id'], name: data['Name'], productImage: data['ProductImage'],
              price: (data['Price'] as int).toDouble(), originPrice: (data['OriginPrice'] as int).toDouble(), 
              categoryId: data['CategoryId'], dateCreated: DateTime.parse(data['DateCreated']),
              stock: (data['Stock'] as int).toInt(), description: data['Description']));
            }).toList();
            storedocs.sort((a, b){ //sorting in ascending order
              return (a.dateCreated).compareTo((b.dateCreated));
            });
            List<Products> latest = [];
            storedocs.take(5).map((p) => {
                latest.add(Products(id: p.id, name: p.name, productImage: p.productImage,
                price: p.price, originPrice: p.originPrice, 
                categoryId: p.categoryId, dateCreated: p.dateCreated,
                stock: p.stock, description: p.description)
                )
              }
            ).toList();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    latest.length,
                    (index) {                     
                      return ProductCard(product: latest[index]); // here by default width and height is 0
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
