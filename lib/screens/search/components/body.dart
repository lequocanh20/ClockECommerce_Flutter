import 'package:clockecommerce/helper/keyboard.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController controller = TextEditingController();
  final Stream<QuerySnapshot> _productStream = 
    FirebaseFirestore.instance.collection('Products').snapshots();
  CollectionReference products = FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // KeyboardUtil.hideKeyboard(context);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: TextFormField(
          autofocus: true,
          textInputAction: TextInputAction.search,
          controller: controller,
          onChanged: (value) => setState(() {
            controller.text == value;
          }),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(0),
                  vertical: getProportionateScreenWidth(10)),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: "Tìm kiếm sản phẩm",
          )
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
          return buildGridView(storedocs.where((p) => p.name.contains(controller.text.toUpperCase())).toList());
        }
      ),
      backgroundColor: Color(0xFFF5F6F9)
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
              KeyboardUtil.hideKeyboard(context);
              Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: data[index]));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                Hero(
                  tag: data[index].id,
                  child: Image.network(data[index].productImage!)),
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
//   String text;
//   getBuildListView(this.text, {Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Products>?> products = ref.watch(productStateFuture);
//     return products.when(
//       loading: () => Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('${err.toString()}')),
//       data: (products) {
//         return buildGridView(products!.where((p) => p.name.contains(text.toUpperCase())).toList());
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
//                 Hero(
//                   tag: data[index].id,
//                   child: Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString())),
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
//}