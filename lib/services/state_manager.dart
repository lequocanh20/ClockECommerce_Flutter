import 'package:clockecommerce/models/categories.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productStateFuture = FutureProvider<List<Products>?>((ref) async {
  return APIService.getAllProduct();
});

final categoryStateFuture = FutureProvider<List<Categories>?>((ref) async {
  return APIService.getAllCategory();
});

final productFeaturedStateFuture = FutureProvider<List<Products>?>((ref) async {
  return APIService.getFeaturedProduct();
});