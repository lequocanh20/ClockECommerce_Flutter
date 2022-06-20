import 'package:clockecommerce/models/categories.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/category/category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final Stream<QuerySnapshot> _categoryStream = 
    FirebaseFirestore.instance.collection('Categories').snapshots();
  CollectionReference categories = FirebaseFirestore.instance.collection('Categories');

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
      child: StreamBuilder<QuerySnapshot>(
        stream: _categoryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          }
          final List<Categories> storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map data = document.data() as Map<String, dynamic>;
            storedocs.add(Categories(id: data['Id'], name: data['Name'], imageCate: data['ImageCate']));
          }).toList();
          
          return Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: storedocs.length,
              itemBuilder: (context, index){
                return CategoryCard(
                  image: storedocs[index].imageCate,
                  press: () {
                    Navigator.pushNamed(context, CategoryScreen.routeName, arguments: storedocs[index]);
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
              child: Image.network(widget.image!),
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


