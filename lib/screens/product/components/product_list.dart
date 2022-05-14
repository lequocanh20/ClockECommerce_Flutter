import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final Stream<QuerySnapshot> _productStream = 
    FirebaseFirestore.instance.collection('Products').snapshots();
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (context, snapshot){
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
        return buildGridView(storedocs.toList());
      }
    );
  }

  GridView buildGridView(List<Products> data) {
    return GridView.builder( 
      padding: EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(      
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6
      ),
      itemCount: data.length,
      itemBuilder: (context, index){
        return Container(
          child: GestureDetector(
            onTap: () async {
              var productDetail = await APIService.getProductById(data[index].id);
              Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString()),
                Row(
                  children: [
                    Expanded(child: Text(data[index].name, style: const TextStyle(fontSize: textSizeList, color: Colors.black), maxLines: 2, overflow: TextOverflow.ellipsis)),
                  ],
                ),  
                Row(
                  children: [
                    Expanded(child: Text(Utilities.formatCurrency(data[index].price), style: const TextStyle(fontSize: textSizeCost, color: textColorCost))),
                  ],
                ),   
              ],      
            ),
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        );
      },
    );
  }
}

// class getBuildListView extends ConsumerWidget {
//   getBuildListView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Products>?> products = ref.watch(productStateFuture);
//     return products.when(
//       loading: () => Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('${err.toString()}')),
//       data: (products) {
//         return buildGridView(products!.toList());
//       }
//     );
//   }

//   GridView buildGridView(List<Products> data) {
//     return GridView.builder( 
//       padding: EdgeInsets.all(5),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(      
//         crossAxisCount: 2,
//         childAspectRatio: 0.65,
//         crossAxisSpacing: 6,
//         mainAxisSpacing: 6
//       ),
//       itemCount: data.length,
//       itemBuilder: (context, index){
//         return Container(
//           child: GestureDetector(
//             onTap: () async {
//               var productDetail = await APIService.getProductById(data[index].id);
//               Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: getProportionateScreenWidth(10)),
//                 Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString()),
//                 Row(
//                   children: [
//                     Expanded(child: Text(data[index].name, style: const TextStyle(fontSize: textSizeList, color: Colors.black), maxLines: 2, overflow: TextOverflow.ellipsis)),
//                   ],
//                 ),  
//                 Row(
//                   children: [
//                     Expanded(child: Text(Utilities.formatCurrency(data[index].price), style: const TextStyle(fontSize: textSizeCost, color: textColorCost))),
//                   ],
//                 ),   
//               ],      
//             ),
//           ),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//         );
//       },
//     );
//   }
// }