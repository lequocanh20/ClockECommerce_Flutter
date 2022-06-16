class CheckedOut {
  CheckedOut({
    required this.id,
    required this.item,
    required this.paymentId,
    required this.amount,
    required this.orderAddress,
    required this.orderEmail,
    required this.orderName,
    required this.orderPhone
  });

  String id;
  List<Object> item;
  String paymentId;
  double amount;
  String orderAddress;
  String orderEmail;
  String orderPhone;
  String orderName;
}