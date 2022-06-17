import 'package:clockecommerce/components/custom_suffix_icon.dart';
import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/components/form_error.dart';
import 'package:clockecommerce/helper/keyboard.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({ Key? key }) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool isAPIcallProcess = false;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
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
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Xác nhận",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isAPIcallProcess = true;
                      });
                      FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((value) async {
                        setState(() {
                          isAPIcallProcess = false;
                        });
                        KeyboardUtil.hideKeyboard(context);
                        FormHelper.showSimpleAlertDialog(
                          context, 
                          "Clock Ecommerce", 
                          "Chúng tôi đã gửi link khôi phục mật khẩu đến bạn. Vui lòng kiểm tra hộp thư.", 
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