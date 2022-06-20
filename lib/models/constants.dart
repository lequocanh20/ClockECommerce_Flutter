import 'package:flutter/material.dart';
import 'package:clockecommerce/models/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const double textSizeList = 12;
const textColorList = Colors.black;

const double textSizeCost = 14;
const textColorCost = Colors.red;

const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))\@gmail[\.]com$');

final RegExp phoneValidatorRegExp =
    RegExp(r'^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$');

const String kEmailNullError = "Vui lòng nhập Email";
const String kInvalidEmailError = "Vui lòng nhập Email hợp lệ";
const String kPassNullError = "Vui lòng nhập mật khẩu";
const String kConfirmPassNullError = "Vui lòng nhập mật khẩu xác nhận";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không khớp";
const String kUserNamelNullError = "Vui lòng nhập tên tài khoản";
const String kNamelNullError = "Vui lòng nhập tên";
const String kInvalidNamelNullError = "Vui lòng nhập tên Hợp lệ";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";
const String kInvalidPhoneNumberNullError = "Số điện thoại có 10 số. Vui lòng nhập số điện thoại hợp lệ";
const String kAddressNullError = "Vui lòng nhập địa chỉ";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(0)),
    borderSide: BorderSide(color: kTextColor),
  );
}