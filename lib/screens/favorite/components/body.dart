import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/favorites.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final Stream<QuerySnapshot> _favoriteStream = 
    FirebaseFirestore.instance.collection('Favorites').snapshots();    
  CollectionReference favorites = FirebaseFirestore.instance.collection('Favorites');
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  List<Products> listProducts = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid = "";
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final User? user = auth.currentUser;
    uid = user!.uid;
    await products.get().then((value) {
      for (var doc in value.docs) {
        listProducts.add(Products(id: doc.get('Id'), originPrice: (doc.get('OriginPrice') as int).toDouble(), 
          price: (doc.get('Price') as int).toDouble(), categoryId: doc.get('CategoryId'), stock: (doc.get('Stock') as int).toInt(), 
          dateCreated: DateTime.parse(doc.get('DateCreated')), name: doc.get('Name'), description: doc.get('Description'),
          productImage: doc.get('ProductImage')));       
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: _favoriteStream,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          final List<Favorites> storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data() as Map<String, dynamic>;
            storedocs.add(Favorites(productId: data['ProductId'], userId: data['UserId']));
          }).toList();          
          final List<Products> result = [];
          for (var i = 0; i < storedocs.length; i++) {
            var element1 = storedocs.elementAt(i);
            for (var j = 0; j < listProducts.length; j++) {
              var element2 = listProducts.elementAt(j);
              if (element1.productId == element2.id && element1.userId == uid) {
                result.add(Products(id: element2.id, originPrice: element2.originPrice, 
                price: element2.price, categoryId: element2.categoryId, stock: element2.stock, 
                dateCreated: element2.dateCreated, name: element2.name, description: element2.description, productImage: element2.productImage));
              }
            }
          }
          return buildGridView(result.toList());
        },
      ),
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
              Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: data[index]));
              // var productDetail = await APIService.getProductById(data[index].id);
              // final result = await Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
              // List<Products>? freshFutureProducts = result as List<Products>;
              // setState(() {
              //   _future = Future.value(freshFutureProducts);
              // });
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
                    Expanded(child: Text(Utilities.formatCurrency(data[index].price), style: const TextStyle(fontSize: textSizeCost, color: textColorCost))),
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
//   const getBuildListView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Products>?> products = ref.watch(productFavoriteStateFuture);
//     return products.when(
//       loading: () => Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('${err.toString()}')),
//       data: (products) {
//         return buildGridView(products!);
//       }
//     );
//   }

//   // ListView buildListView(List<Products> data) {
//   //   print(data.toString());
//   //   return ListView.builder( 
//   //     itemCount: data.length,
//   //     itemBuilder: (context, index){
//   //       return ListTile(
//   //         // leading: data[index].id != null ? Image.network('${Utilities.host}${data[index].image}'),
//   //         leading: Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString()),
//   //         title: Text(data[index].name),
//   //         trailing: Text(Utilities.formatCurrency(data[index].price)),
//   //         onTap: () async {
//   //           var productDetail = await APIService.getProductById(data[index].id);
//   //           Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
//   //         });
//   //     },
//   //   );
//   // }

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
//                     Expanded(child: Text(data[index].name, style: const TextStyle(fontSize: textSizeList, color: textColorList), maxLines: 2, overflow: TextOverflow.ellipsis)),
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
//             // gradient: LinearGradient(
//             //   colors: [
//             //     Colors.orange.withOpacity(0.8),
//             //     Colors.grey
//             //   ],
//             //   begin: Alignment.topLeft,
//             //   end: Alignment.bottomRight
//             // ),
//             color: Colors.white,
//           ),
//         );
//       },
//     );
//   }
// }