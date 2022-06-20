import 'package:clockecommerce/models/checkedout.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({ Key? key }) : super(key: key);
  static String routeName = '/Orders';
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  CollectionReference checkedout = FirebaseFirestore.instance.collection('Checkedout');
  List<CheckedOut> listCheckedOut = [];
  List product = [];
  @override
  void initState() {
    super.initState();
    fetchDataCart();
  }
  fetchDataCart() async {
    await checkedout.get().then((value) {
      for (var doc in value.docs) {
        if(doc.get('OrderEmail') == FirebaseAuth.instance.currentUser!.email) {
          setState(() {
            listCheckedOut.add(CheckedOut(id: doc.get('Id'), item: doc.get('OrderItems'), 
            paymentId: doc.get('PaymentId'), orderAddress: doc.get('OrderAddress'), orderEmail: doc.get('OrderEmail'), 
            orderName: doc.get('OrderName'), orderPhone: doc.get('OrderName'), amount: doc.get('Amount')));
          });             
        }          
      }
      for (var l in listCheckedOut) {
        for (var p in l.item) {
          product.add(p);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text("Lịch sử mua hàng", style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor),
      body: SafeArea(
        child: ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) {
            return Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
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
                                  tag: product[index]['ProductId'].toString(),
                                  child: Image.network(product[index]['ProductImage']),
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
                                  product[index]['Name'].toString(),
                                  style: const TextStyle(color: textColorList, fontSize: textSizeList),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(
                                    text: Utilities.formatCurrency(product[index]['Price']),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                                  ),
                                ),
                                Text.rich(
                                  TextSpan(
                                          text: "Số lượng: ${product[index]['Quantity']}",
                                          style: Theme.of(context).textTheme.bodyText1),
                                ),
                                const SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(
                                    text: "Ngày mua: ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                                    children: [
                                      TextSpan(
                                        text: DateTime.parse(product[index]['DatePurchase'].toString()).day.toString() + '/' +
                                              DateTime.parse(product[index]['DatePurchase'].toString()).month.toString() + '/' +
                                              DateTime.parse(product[index]['DatePurchase'].toString()).year.toString(),
                                        style: Theme.of(context).textTheme.bodyText1)                   
                                      ]
                                    ),
                                )
                              ],
                            ),
                          ),      
                        ],
                      )
                    ],
                  ),
                ),
              )
            );
          },
        ),
      ),
    );
  }
}