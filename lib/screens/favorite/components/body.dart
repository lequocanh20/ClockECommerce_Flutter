import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/services/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../services/api_service.dart';

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Products>?> _future;
  @override
  void initState() {
    super.initState();
    _future = APIService.getAllFavoriteProduct();
  }

  Future<void> _pullRefresh() async {
    List<Products>? freshFutureProducts = await APIService.getAllFavoriteProduct();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _future = Future.value(freshFutureProducts);   
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        child: FutureBuilder<List<Products>?>(
          future: _future,
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return buildGridView(snapshot.data!);
          },
        ),
        onRefresh: _pullRefresh,
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
              var productDetail = await APIService.getProductById(data[index].id);
              final result = await Navigator.pushNamed(context, DetailsScreen.routeName, arguments: ProductDetailsArguments(product: productDetail));
              List<Products>? freshFutureProducts = result as List<Products>;
              setState(() {
                _future = Future.value(freshFutureProducts);
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenWidth(10)),
                Image.network(Uri.https(Config.apiURL, data[index].productImage!).toString()),
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