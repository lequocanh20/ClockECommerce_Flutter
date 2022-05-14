import 'dart:convert';
import 'dart:ffi';

import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final String id;
  const CategoryDetail(this.id, {Key? key}) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  final Stream<QuerySnapshot> _productStream = 
    FirebaseFirestore.instance.collection('Products').snapshots();
  CollectionReference products = FirebaseFirestore.instance.collection('Categories');
  // late Future<List<Products>?> _future;
  // List<Products>? products;
  // bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // fetchData();
    // _future = APIService.getAllProduct();
  }

  // fetchData() async {    
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var item = await APIService.getAllProduct();
  //   if (item != null)  {     
  //     setState(() {
  //       isLoading = false;
  //       products = item;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //       products = [];
  //     });
  //   }
  // }

  // List<Products> getProductFromCate(int id) {
  //   return products!.where((p) => p.categoryId == id).toList();
  // }

  @override
  Widget build(BuildContext context) {
    // if (products == null || isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // return getBuildListView(widget.id);
    return StreamBuilder<QuerySnapshot>(
      stream: _productStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child : CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        final List<Products> storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(Products(id: (a['Id'] as int).toInt(), name: a['Name'], price: (a['Price'] as int).toDouble(), originPrice: (a['OriginPrice'] as int).toDouble(), stock: (a['Stock'] as int).toInt(), dateCreated: (a['DateCreated'] as Timestamp).toDate(), categoryId: a['CategoryId'], description: a['Description'], productImage: a['ProductImage']));
          }).toList();  
        return buildGridView(storedocs.where((p) => p.categoryId == widget.id).toList());
      }
    );
  }

  GridView buildGridView(List<Products> data) {
    return GridView.builder( 
      padding: const EdgeInsets.all(5),
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
              // var productDetail = await APIService.getProductById(data[index].id);
              // Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                Image.network(data[index].productImage!),
                Row(
                  children: [
                    Expanded(child: Text(data[index].name, style: const TextStyle(fontSize: textSizeList, color: textColorList), maxLines: 2, overflow: TextOverflow.ellipsis)),
                  ],
                ),  
                Row(
                  children: [
                    Expanded(child: Text(Utilities.formatCurrency(data[index].price), style: const TextStyle(fontSize: 14, color: Colors.red))),
                  ],
                ),   
              ],      
            ),
          ),
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Colors.orange.withOpacity(0.8),
            //     Colors.grey
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight
            // ),
            color: Colors.white,
          ),
        );
      },
    );
  }
}

// class getBuildListView extends ConsumerWidget {
//   int id;
//   getBuildListView(this.id, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Products>?> products = ref.watch(productStateFuture);
//     return products.when(
//       loading: () => Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('${err.toString()}')),
//       data: (products) {
//         return buildGridView(products!.where((p) => p.categoryId == id).toList());
//       }
//     );
//   }

  // ListView buildListView(List<Products> data) {
  //   print(data.toString());
  //   return ListView.builder( 
  //     itemCount: data.length,
  //     itemBuilder: (context, index){
  //       return ListTile(
  //         // leading: data[index].id != null ? Image.network('${Utilities.host}${data[index].image}'),
  //         leading: Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString()),
  //         title: Text(data[index].name),
  //         trailing: Text(Utilities.formatCurrency(data[index].price)),
  //         onTap: () async {
  //           var productDetail = await APIService.getProductById(data[index].id);
  //           Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
  //         });
  //     },
  //   );
  // }

  // GridView buildGridView(List<Products> data) {
  //   return GridView.builder( 
  //     padding: EdgeInsets.all(5),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(      
  //       crossAxisCount: 2,
  //       childAspectRatio: 0.65,
  //       crossAxisSpacing: 6,
  //       mainAxisSpacing: 6
  //     ),
  //     itemCount: data.length,
  //     itemBuilder: (context, index){
  //       return Container(
  //         child: GestureDetector(
  //           onTap: () async {
  //             var productDetail = await APIService.getProductById(data[index].id);
  //             Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
  //           },
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(height: getProportionateScreenWidth(10)),
  //               Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString()),
  //               Row(
  //                 children: [
  //                   Expanded(child: Text(data[index].name, style: TextStyle(fontSize: textSizeList, color: textColorList), maxLines: 2, overflow: TextOverflow.ellipsis)),
  //                 ],
  //               ),  
  //               Row(
  //                 children: [
  //                   Expanded(child: Text(Utilities.formatCurrency(data[index].price), style: const TextStyle(fontSize: 14, color: Colors.red))),
  //                 ],
  //               ),   
  //             ],      
  //           ),
  //         ),
  //         decoration: const BoxDecoration(
  //           // gradient: LinearGradient(
  //           //   colors: [
  //           //     Colors.orange.withOpacity(0.8),
  //           //     Colors.grey
  //           //   ],
  //           //   begin: Alignment.topLeft,
  //           //   end: Alignment.bottomRight
  //           // ),
  //           color: Colors.white,
  //         ),
  //       );
  //     },
  //   );
  // }
// }