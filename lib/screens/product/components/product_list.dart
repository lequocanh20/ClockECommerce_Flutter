import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:clockecommerce/screens/details/details_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:clockecommerce/services/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return getBuildListView();
  }
}

class getBuildListView extends ConsumerWidget {
  getBuildListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Products>?> products = ref.watch(productStateFuture);
    return products.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('${err.toString()}')),
      data: (products) {
        return buildGridView(products!.toList());
      }
    );
  }

  GridView buildGridView(List<Products> data) {
    return GridView.builder( 
      padding: EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(      
        crossAxisCount: 2,
        childAspectRatio: 0.7,
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
                    Expanded(child: Text(data[index].name.length > 28 ? data[index].name.substring(0, 34) + "..." : data[index].name, style: const TextStyle(fontSize: 15), maxLines: 2)),
                  ],
                ),  
                Row(
                  children: [
                    Expanded(child: Text(Utilities.formatCurrency(data[index].price), style: const TextStyle(fontSize: 15))),
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