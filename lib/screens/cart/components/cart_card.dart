import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/items.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:flutter/material.dart';
class CartCard extends StatefulWidget {
  final Cart items;
  CartCard({
    Key? key,
    required this.items
  }) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 1.02,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(5)),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
              ),
              child: Hero(
                tag: widget.items.productId.toString(),
                child: Image.network(widget.items.productImage!),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(
                widget.items.name.toString(),
                style: const TextStyle(color: textColorList, fontSize: textSizeList),
                maxLines: 2,
              ),
              const SizedBox(height: 2),
              Text.rich(
                TextSpan(
                  text: Utilities.formatCurrency(widget.items.price),
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
              ),
              const SizedBox(height: 2),
              Text.rich(
                TextSpan(
                        text: "Số lượng: ${widget.items.quantity}",
                        style: Theme.of(context).textTheme.bodyText1),
              )
            ],
          ),
        ),      
      ],
    );
  }
}
