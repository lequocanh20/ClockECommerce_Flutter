import 'package:clockecommerce/components/custom_suffix_icon.dart';
import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/components/form_error.dart';
import 'package:clockecommerce/helper/keyboard.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool isAPIcallProcess = false;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final List<String> errors = [];
  late FToast fToast;

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

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    if (isAPIcallProcess) {
      return const Center(child: CircularProgressIndicator());
    }
    return Form(
            key: _formKey,
            child: Column(
              children: [
                buildEmailFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPasswordFormField(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () => {},
                      // Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                      child: TextButton(
                        child: const Text(
                          "Quên mật khẩu",
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                        onPressed: () => {
                          Navigator.pushNamed(context, ForgotPasswordScreen.routeName)
                        },
                      ),
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Đăng nhập",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isAPIcallProcess = true;
                      });
                      FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) async {
                        setState(() {
                          isAPIcallProcess = false;
                        });
                        KeyboardUtil.hideKeyboard(context);
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          HomeScreen.routeName, 
                          (route) => false
                        );
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
                    }
                    // if all are valid then go to success screen
                    
                  }
                ),
              ],
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
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "Nhập mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
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
}
