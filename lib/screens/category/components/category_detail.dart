import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final int id;
  const CategoryDetail(this.id, {Key? key}) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  late Future<List<Products>?> _future;
  // List<Products>? products;
  // bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // fetchData();
    _future = APIService.getAllProduct();
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

  Future<void> _pullRefresh() async {
    List<Products>? freshFutureProducts = await APIService.getAllProduct();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _future = Future.value(freshFutureProducts);   
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (products == null || isLoading) {
    //   return const Center(child: CircularProgressIndicator());
    // }
    // return getBuildListView(widget.id);
    return FutureBuilder<List<Products>?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child : CircularProgressIndicator());
        }
        else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }  
        return RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          displacement: 20,
          edgeOffset: 0,
          child: buildGridView(snapshot.data!.where((p) => p.categoryId == widget.id).toList()), 
          onRefresh: _pullRefresh
        );
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