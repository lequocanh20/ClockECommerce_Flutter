import 'package:clockecommerce/components/rounded_icon_btn.dart';
import 'package:clockecommerce/models/product_detail.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key? key,
    required this.product,
  }) : super(key: key);

  // final Products product;
  final ProductDetail product;

  @override
  State<ColorDots> createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int countItem = 1;
  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    // int selectedColor = 3;
    void _upCounter() {
      setState(() {
        // This call to setState tells the Flutter framework that something has
        // changed in this State, which causes it to rerun the build method below
        // so that the display can reflect the updated values. If we changed
        // _counter without calling setState(), then the build method would not be
        // called again, and so nothing would appear to happen.
        countItem++;
      });
    }
    void _downCounter() {
      setState(() {
        countItem > 1 ? countItem-- : countItem;
      });
    }

    @override
    void initState() {
      super.initState();
      countItem = 1;
    }
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Utilities.formatCurrency(widget.product.price), style: TextStyle(color: Colors.red, fontSize: 25),),
          SizedBox(height: getProportionateScreenWidth(10)), 
          Row(
            children: [
              // ...List.generate(
              //   widget.product.colors.length,
              //   (index) => ColorDot(
              //     color: widget.product.colors[index],
              //     isSelected: index == selectedColor,
              //   ),
              // ),
              // Spacer(),
              SizedBox(height: getProportionateScreenWidth(50)),
              RoundedIconBtn(
                icon: Icons.remove,
                press: () {
                  _downCounter();
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              Text(countItem.toString(), style: TextStyle(fontSize: 18),),
              SizedBox(width: getProportionateScreenWidth(20)),
              RoundedIconBtn(
                icon: Icons.add,
                showShadow: true,
                press: () {
                  _upCounter();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class ColorDot extends StatelessWidget {
//   const ColorDot({
//     Key? key,
//     required this.color,
//     this.isSelected = false,
//   }) : super(key: key);

//   final Color color;
//   final bool isSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(right: 2),
//       padding: EdgeInsets.all(getProportionateScreenWidth(8)),
//       height: getProportionateScreenWidth(40),
//       width: getProportionateScreenWidth(40),
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         border:
//             Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
//         shape: BoxShape.circle,
//       ),
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }
