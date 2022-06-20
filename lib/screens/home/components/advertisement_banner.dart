import 'package:clockecommerce/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ImageSlideshow(
          width: double.infinity,
          height: 200,
          initialPage: 0,
          indicatorColor: kPrimaryColor,
          indicatorBackgroundColor: Colors.grey,
          onPageChanged: (value) {
          },
          autoPlayInterval: 3000,
          isLoop: true,
          children: [
            Image.asset(
              'assets/images/Image Banner 2.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/Image Banner 3.png',
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/Image Popular Product 1.png',
              fit: BoxFit.cover,
            ),
          ],
      )
    );
  }
}
