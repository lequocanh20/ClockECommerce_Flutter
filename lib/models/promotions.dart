class Promotions {
  Promotions({
    required this.id,
    required this.name,
    required this.codePromotion,
    required this.salesOff,
    required this.maxPrice,
    required this.promotionImage,
    required this.expiredDate
  });
  String id;
  String name;
  String codePromotion;
  double salesOff;
  double maxPrice;
  String promotionImage;
  String expiredDate;
}