import 'dart:convert';

import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/carts.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/users.dart';
import 'package:clockecommerce/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Users> listUsers = [];
  final email = TextEditingController();
  final name = TextEditingController();
  final phone = TextEditingController();
  final address = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  // LoginResponseModel? model;
  @override
  void initState() {
    super.initState();
    _getData();    
  }
  _getData() async {
    // model = await SharedService.loginDetails();
    // email.text = model!.name;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    await users.get().then((value) {
      for (var doc in value.docs) {
        listUsers.add(Users(id: doc.get('Id'), name: doc.get('Name'), address: doc.get('Address'), 
        email: doc.get('Email'), phone: doc.get('Phone')));      
      }
    });
    // var model = await APIService.getUserProfile();
    // email.text = model.resultObj.email;
    // name.text = model.resultObj.name;
    // phone.text = model.resultObj.phoneNumber;
    // address.text = model.resultObj.address;
    for (var i = 0; i < listUsers.length; i++) {
      var element = listUsers.elementAt(i);
      if (element.id == uid) {
        email.text = element.email;
        name.text = element.name;
        phone.text = element.phone;
        address.text = element.address;
      }
    }
  }
  CollectionReference checkedout = FirebaseFirestore.instance.collection('Checkedout');
  CollectionReference carts = FirebaseFirestore.instance.collection('Carts');
  List userListProduct = [];
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    final InformCartArguments agrs =
        ModalRoute.of(context)!.settings.arguments as InformCartArguments;
    print(agrs);
    //  Future<Map<String, dynamic>>
    calculateAmount(double amount) {
      final a = (amount).toInt();
      return a.toString();
    }
    createPaymentIntent(double amount, String currency) async {
      try {
        Map<String, dynamic> body = {
          'description': 'Thanh toan dong ho tai Clock Ecommerce',
          'amount': calculateAmount(amount),
          'currency': currency,
          'payment_method_types[]': 'card',
          'receipt_email': 'lequocanh.huflit@gmail.com'
        };
        print(body);
        var response = await http.post(
            Uri.parse('https://api.stripe.com/v1/payment_intents'),
            body: body,
            headers: {
              'Authorization': 'Bearer sk_test_51K2C1tGvDddAkKFYNEn9tIptqJZoxZhGWk8yBNUWae9uLksd6bkHHyEWKrHAhi2DvmLDSPe0wyxAGmk0gSCRlXu800VEXM0Ii6',
              'Content-Type': 'application/x-www-form-urlencoded'
            });
        print('Create Intent reponse ===> ${response.body.toString()}');
        return jsonDecode(response.body);
      } catch (err) {
        print('err charging user: ${err.toString()}');
      }
    }
      displayPaymentSheet() async {

      try {
        await Stripe.instance.presentPaymentSheet(
            parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true,
            )).then((newValue){


          print('payment intent'+paymentIntentData!['id'].toString());
          print('payment intent'+paymentIntentData!['client_secret'].toString());
          print('payment intent'+paymentIntentData!['amount'].toString());
          print('payment intent'+paymentIntentData.toString());
          //orderPlaceApi(paymentIntentData!['id'].toString());
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
          for (int i = 0; i < agrs.cartDetails.length; i++) {
            userListProduct.add({
              "ProductId": agrs.cartDetails[i].productId,
              "Price": agrs.cartDetails[i].price,
              "ProductImage": agrs.cartDetails[i].productImage,
              "Quantity": agrs.cartDetails[i].quantity,
              "Name": agrs.cartDetails[i].name,
              "DatePurchase": DateTime.now().toString()
            });
          }
          String id = checkedout.doc().id;
          final data = {
            "Id": id, 
            "PaymentId": paymentIntentData!['id'].toString(),
            "OrderName": name.text,
            "OrderEmail": email.text,
            "OrderPhone": phone.text,
            "OrderAddress": address.text,                      
            "OrderItems": FieldValue.arrayUnion(userListProduct),
            "Amount": (paymentIntentData!['amount'] as int).toDouble(),
          };
          checkedout.doc(id).set(data).then((value) => {}).catchError((error) => print('Failed to Add Checked Out Into Firebase: $error'));
          for (int i = 0; i < agrs.cartDetails.length; i++) {
            carts
              .doc(agrs.cartDetails[i].productId! + FirebaseAuth.instance.currentUser!.uid)
              .delete()
              .then((value) => print('Cart Deleted'))
              .catchError((error) => print('Failed to Delete Cart: $error'));
          }
          Fluttertoast.showToast(
            msg: "Bạn đã đặt hàng thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
          );
          Navigator.pushNamed(context, HomeScreen.routeName);
          paymentIntentData = null;

        }).onError((error, stackTrace){
          print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        });


      } on StripeException catch (e) {
        print('Exception/DISPLAYPAYMENTSHEET==> $e');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text("Cancelled "),
            ));
      } catch (e) {
        print('$e');
      }
    }
    Future<void> makePayment(double amount) async {
      try {

        paymentIntentData =
        await createPaymentIntent(amount, 'VND'); //json.decode(response.body);
        // print('Response body==>${response.body.toString()}');
        final billingDetails = BillingDetails(
          name: 'LE QUOC ANH',
          email: 'lequocanh.qa@gmail.com',
          phone: '+84774642207',
          address: Address(
            city: 'TPHCM',
            country: 'VN',
            line1: 'Lien Ap 2-6',
            line2: '',
            state: 'Binh Chanh',
            postalCode: '700000',
          ),
        );
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                customerId: paymentIntentData!['customer'],
                customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
                applePay: true,
                googlePay: true,
                testEnv: true,
                style: ThemeMode.dark,
                billingDetails: billingDetails,
                merchantCountryCode: 'VN',
                merchantDisplayName: 'Clock Ecommerce')).then((value){
        });


      ///now finally display payment sheeet
        displayPaymentSheet();
      } catch (e, s) {
        print('exception:$e$s');
      }
    }
    return SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 5,),
            nameTextFormField(),
            const SizedBox(height: 5,),
            addressTextFormField(),
            const SizedBox(height: 5,),
            phoneTextFormField(),
            const SizedBox(height: 5,),
            emailTextFormField(),
            const SizedBox(height: 10,),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context, email.text);
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: kPrimaryColor,
                child: DefaultButton(
                  text: "Thanh toán",
                  press: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("Xác nhận đặt hàng"),
                      content: const Text("Bạn sẽ xác nhận đặt hàng chứ ?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Hủy'),
                          child: Text('Hủy'),
                        ),
                        TextButton(
                          onPressed: () async {
                            await makePayment(agrs.sum);       
                          },
                          child: Text('Xác nhận'),
                        ),
                      ],
                    )
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );

  }

  TextFormField nameTextFormField() {
    return TextFormField(
      readOnly: true,
      showCursor: false,
      enableInteractiveSelection: false,
      controller: name,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Tên",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField addressTextFormField() {
    return TextFormField(
      controller: address,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Địa chỉ",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField phoneTextFormField() {
    return TextFormField(
      readOnly: true,
      showCursor: false,
      enableInteractiveSelection: false,
      controller: phone,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Số điện thoại",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }

  TextFormField emailTextFormField() {
    return TextFormField(
      readOnly: true,
      showCursor: false,
      enableInteractiveSelection: false,
      controller: email,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Email",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.email_outlined)
      ),
    );
  }
}

class InformCartArguments {
  double sum = 0.0;
  List<Cart> cartDetails = [];
  
  InformCartArguments({required this.cartDetails, required this.sum});
}