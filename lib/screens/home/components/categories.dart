import 'package:clockecommerce/models/categories.dart';
import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/category/category_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late Future<List<Categories>?> _future;
  @override
  void initState() {
    super.initState();
    _future = APIService.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> categories = [
    //   {"icon": "assets/icons/Flash Icon.svg", "text": "Deal chớp nhoáng"},
    //   {"icon": "assets/icons/Bill Icon.svg", "text": "Hoá đơn"},
    //   {"icon": "assets/icons/Game Icon.svg", "text": "Game"},
    //   {"icon": "assets/icons/Gift Icon.svg", "text": "Quà tặng hằng ngày"},
    //   {"icon": "assets/icons/Discover.svg", "text": "Thêm nữa..."},
    // ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: FutureBuilder<List<Categories>?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          return Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:snapshot.data!.length,
              itemBuilder: (context, index){
                return CategoryCard(
                  image: snapshot.data![index].imageCate,
                  press: () {
                    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: snapshot.data![index]);
                  },
                );
              },
          ),
        );
        }),
    );
  }
}

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
    this.image,
    // required this.text,
    required this.press,
  }) : super(key: key);

  final String? image;
  // final String text;
  final GestureTapCallback press;

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.press,
      child: SizedBox(
        width: getProportionateScreenWidth(85),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(1)),
              height: getProportionateScreenWidth(80),
              width: getProportionateScreenWidth(80),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(0),
              ),
              child: Image.network(Uri.https(Config.apiURL, widget.image!).toString()),
            ),
            SizedBox(height: 5),
            // Text(text, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

// class GetCategory extends ConsumerWidget {
//   var test;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     AsyncValue<List<Categories>?> categories = ref.watch(categoryStateFuture);
//     return categories.when(
//       loading:() => Center(child: CircularProgressIndicator()),
//       error: (err, stack) => Center(child: Text('${err.toString()}')),
//       data: (categories) {        
//         return Container(
//           width: MediaQuery.of(context).size.width,
//           height: 100,
//           child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount:categories!.length,
//               itemBuilder: (context, index){
//                 return CategoryCard(
//                   image: categories[index].imageCate,
//                   press: () {
//                     Navigator.pushNamed(context, CategoryScreen.routeName, arguments: categories[index]);
//                   },
//                 );
//               },
//           ),
//         );
//       }
//     );
//   }
// }


