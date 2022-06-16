class CheckedOut {
  CheckedOut({
    required this.id,
    required this.item,
    required this.paymentId,
    required this.userId,
  });

  String id;
  List<Object> item;
  String paymentId;
  String userId;
}