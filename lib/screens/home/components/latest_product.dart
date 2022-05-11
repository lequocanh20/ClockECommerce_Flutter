import 'package:clockecommerce/components/product_card.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/product/product_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:clockecommerce/services/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'section_title.dart';

class LatestProducts extends StatefulWidget {
  final Future<List<Products>?> future;
  const LatestProducts({Key? key, required this.future}) : super(key: key);

  @override
  State<LatestProducts> createState() => _LatestProductsState();
}

class _LatestProductsState extends State<LatestProducts> {
  late Future<List<Products>?> _future;  

  @override
  void initState() {
    super.initState();
    _future = widget.future;  
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _future = widget.future;
    });
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
        FutureBuilder<List<Products>?>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    snapshot.data!.length,
                    (index) {                     
                      return ProductCard(product: snapshot.data![index]); // here by default width and height is 0
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
