import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName);
      },
      child: Container(
        width: SizeConfig.screenWidth! * 0.6,
        height: 50,
        decoration: BoxDecoration(
          color: kSecondaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
      child: Row(
        children: [
          SizedBox(width: getProportionateScreenWidth(5)),
          Icon(Icons.search),
          SizedBox(width: getProportionateScreenWidth(5)),
          const Text("Tìm kiếm sản phẩm")
        ],
      ),
      // child: Row(
      //   children: [
      //         IconButton(
      //       icon: Icon(Icons.search),
      //       alignment: Alignment.centerLeft,
      //       onPressed: () {
      //         // Navigator.pushNamed(context, SearchScreen.routeName);
      //       },
      //     ),
      //     const Text("Tìm kiếm sản phẩm")
      //   ],
      // ),
      ),
    );
  }
}
