import 'package:clockecommerce/components/default_button.dart';
import 'package:clockecommerce/models/constants.dart';
import 'package:clockecommerce/models/promotions.dart';
import 'package:clockecommerce/models/size_config.dart';
import 'package:clockecommerce/models/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PromotionScreen extends StatefulWidget {
  static String routeName = '/Promotions';
  const PromotionScreen({ Key? key }) : super(key: key);

  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  CollectionReference promotions = FirebaseFirestore.instance.collection('Promotions');
  List<Promotions> promotionList = [];
  String? promotion = '';
  @override
  void initState() {
    super.initState();
    fetchDataPromotion();
  }

  fetchDataPromotion() async {
    await promotions.get().then((value) {
      for (var doc in value.docs) {
        setState(() {
          promotionList.add(Promotions(id: doc.get('Id'), name: doc.get('Name'), 
          codePromotion: doc.get('CodePromotion'), salesOff: (doc.get('SalesOff') as int).toDouble(), maxPrice: (doc.get('MaxPrice') as int).toDouble(),
          promotionImage: doc.get('PromotionImage'), expiredDate: DateTime.parse((doc.get('ExpiredDate') as Timestamp).toDate().toString()).toString()));
        });                      
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
        title: Text("Khuyến mãi đặc biệt", style: TextStyle(color: Colors.black)),
        backgroundColor: kPrimaryColor,),
      body: SafeArea(
        child: ListView.builder(
          itemCount: promotionList.length,
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
                            child: Image.network(promotionList[index].promotionImage),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                  promotionList[index].name.toString() + ' giảm giá ' + promotionList[index].salesOff.toString() + '%' + ' tối đa ' + Utilities.formatCurrency(promotionList[index].maxPrice),
                                  style: const TextStyle(color: textColorList, fontSize: textSizeList),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Text.rich(
                                      TextSpan(
                                        text: "Ngày hết hạn: ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600, color: kPrimaryColor),
                                        children: [
                                          TextSpan(
                                            text: DateTime.parse(promotionList[index].expiredDate.toString()).day.toString() + '/' +
                                                  DateTime.parse(promotionList[index].expiredDate.toString()).month.toString() + '/' +
                                                  DateTime.parse(promotionList[index].expiredDate.toString()).year.toString(),
                                            style: Theme.of(context).textTheme.bodyText1),                   
                                          ]
                                        ),
                                    ),
                                    Radio(
                                      value: promotionList[index].id, 
                                      groupValue: promotion, 
                                      onChanged: (value){
                                        setState(() {
                                          promotion = value.toString();
                                        });
                                      }
                                    ),
                                  ],
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
      bottomNavigationBar: DefaultButton(
        text: "Tiếp tục",
          press: () => {
            Navigator.pop(context, promotion)
          },
      ),
    );
  }
}