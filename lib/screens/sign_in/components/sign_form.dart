import 'package:clockecommerce/components/custom_surfix_icon.dart';
import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/components/form_error.dart';
import 'package:clockecommerce/helper/keyboard.dart';
import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/login_request_model.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/screens/login_success/login_success_screen.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool isAPIcallProcess = false;
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool remember = false;
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
                    Checkbox(
                      value: remember,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          remember = value!;
                        });
                      },
                    ),
                    Text("Nhớ mật khẩu"),
                    Spacer(),
                    GestureDetector(
                      onTap: () => {},
                      // Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(20)),
                DefaultButton(
                  text: "Tiếp tục",
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isAPIcallProcess = true;
                      });
                      LoginRequestModel model = LoginRequestModel(
                        username: email.text, 
                        password: password.text);                  
                      APIService.login(model).then((response) async {                   
                        setState(() {
                          isAPIcallProcess = false;
                        });
                        if (response.resultObj != null) {
                          KeyboardUtil.hideKeyboard(context);
                          Navigator.pushNamedAndRemoveUntil(
                          context, 
                          LoginSuccessScreen.routeName, 
                          (route) => false);
                        }
                        else {
                          FormHelper.showSimpleAlertDialog(
                          context, 
                          Config.appName, 
                          response.message!, 
                          "OK", 
                          () {
                            KeyboardUtil.hideKeyboard(context);
                            Navigator.pop(context);
                          });
                        }
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
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email.text = newValue!,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   return null;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
