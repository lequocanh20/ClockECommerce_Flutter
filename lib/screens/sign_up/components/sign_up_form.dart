import 'package:clockecommerce/components/custom_suffix_icon.dart';
import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/components/form_error.dart';
import 'package:clockecommerce/helper/keyboard.dart';
import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/register_request_model.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  final username = TextEditingController();
  final address = TextEditingController();
  bool isAPIcallProcess = false;
  bool remember = false;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    if (isAPIcallProcess) {
      return const Center(child: CircularProgressIndicator());
    }
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {
                  isAPIcallProcess = true;
                });
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value) async {
                  final data = {
                    "Id": value.user!.uid,
                    "Name": name.text,
                    "Email": email.text,
                    "Phone": phone.text,
                    "Address": address.text
                };
                  users
                  .doc(value.user!.uid)
                  .set(data)
                  .then((value) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    KeyboardUtil.hideKeyboard(context);
                    FormHelper.showSimpleAlertDialog(
                      context, 
                      "Clock Ecommerce", 
                      "Đăng ký tài khoản thành công! Tiến hành đăng nhập để sử dụng.", 
                      "OK", 
                      () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        setState(() {
                          isAPIcallProcess = false;
                        });
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          SignInScreen.routeName, 
                          (route) => false
                        );
                      }
                    );
                    // Navigator.pushNamedAndRemoveUntil(
                    //   context, 
                    //   SignInScreen.routeName, 
                    //   (route) => false
                    // );
                  })
                  .catchError((error) => print('create user fail: $error'));                 
                }).catchError((e) {
                  FormHelper.showSimpleAlertDialog(
                    context, 
                    "Clock Ecommerce", 
                    e.message, 
                    "OK", 
                    () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      setState(() {
                        isAPIcallProcess = false;
                      });
                      Navigator.pop(context);
                    }
                  );
                });
                // if all are valid then go to success screen
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                // RegisterRequestModel model = RegisterRequestModel(
                //     name: name,
                //     email: email,
                //     address: address,
                //     phoneNumber: phone,
                //     userName: username, 
                //     password: password,
                //     confirmPassword: confirmpassword
                //   );                  
                  // APIService.register(model).then((response) async {                   
                  //   setState(() {
                  //     isAPIcallProcess = false;
                  //   });

                  //   if (response.resultObj != null) {
                  //     FormHelper.showSimpleAlertDialog(
                  //       context, 
                  //       Config.appName, 
                  //       "Đăng ký thành công. Vui lòng xác thực email trước khi đăng nhập.", 
                  //       "OK", 
                  //       () {
                  //         Navigator.pushNamedAndRemoveUntil(
                  //           context, 
                  //           SignInScreen.routeName, 
                  //           (route) => false
                  //         );
                  //       }
                  //     );                                          
                  //   }
                  //   else {
                  //     FormHelper.showSimpleAlertDialog(
                  //       context, 
                  //       Config.appName, 
                  //       response.message!, 
                  //       "OK", 
                  //       () {
                  //         Navigator.pop(context);
                  //       });
                  //   }
                  // });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmpassword.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kConfirmPassNullError);
        } else if (value.isNotEmpty && password.text == confirmpassword.text) {
          removeError(error: kMatchPassError);
        }
        confirmpassword.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kConfirmPassNullError);
          return "";
        } else if ((password.text != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập lại mật khẩu",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          removeError(error: kShortPassError);
          return "";
        } else if (value.length < 7) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập mật khẩu",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        // enabledBorder: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(0),
        //         )
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }      
        email.text = value;        
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          removeError(error: kInvalidEmailError);
          return "";
        } 
        else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập email",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        name.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập tên",
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        address.text = value;     
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập địa chỉ",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone.text = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        phone.text = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập số điện thoại",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
