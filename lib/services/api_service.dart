import 'dart:convert';
import 'package:clockecommerce/models/categories.dart';
import 'package:clockecommerce/models/config.dart';
import 'package:clockecommerce/models/favorite_request_model.dart';
import 'package:clockecommerce/models/favorite_response_model.dart';
import 'package:clockecommerce/models/login_request_model.dart';
import 'package:clockecommerce/models/login_response_model.dart';
import 'package:clockecommerce/models/product_detail.dart';
import 'package:clockecommerce/models/products.dart';
import 'package:clockecommerce/models/register_request_model.dart';
import 'package:clockecommerce/models/register_response_model.dart';
import 'package:clockecommerce/models/user_view_model.dart';
import 'package:clockecommerce/services/shared_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  // static Future<bool> login(LoginRequestModel model) async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //   };

  //   var url = Uri.https(Config.apiURL, Config.loginAPI);

  //   var response = await client.post(
  //     url, 
  //     headers: requestHeaders, 
  //     body: jsonEncode(model.toJson()),);
  //   if (response.statusCode == 200) {
  //     await SharedService.setLoginDetails(loginResponseJson(response.body));
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  static Future<LoginResponseModel> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url, 
      headers: requestHeaders, 
      body: jsonEncode(model.toJson()),);
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return loginResponseJson(response.body);
    } else {
      return loginResponseJson(response.body);
    }
  }

  static Future<UserViewModel> getUserProfile() async {

    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.resultObj}'
    };

    var url = Uri.https(Config.apiURL, Config.userProfileAPI + loginDetails.resultObj!);

    var response = await client.get(
      url, 
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return UserViewModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.https(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseModel(response.body);
  }
 
  // static Future getAllCategory() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json'
  //   };
  //   // var url = Uri.https(Config.apiURL, Config.categoryAPI);

  //   // var response = await client.get(
  //   //   url, 
  //   //   headers: requestHeaders,
  //   // );
  //   // if (response.statusCode == 200) {
  //   //   return Categories.fromJson(json.decode(response.body));
  //   // }
  //   // else {
  //   //   throw Exception("Failed to load cate api");
  //   // }

  //   var url = Uri.https(Config.apiURL, Config.categoryAPI);
  //   var response = await http.get(url, headers: requestHeaders);
  //   if (response.statusCode == 200)  {
  //     return json.decode(response.body)["data"];
  //   } else {
  //     throw Exception("Failed to load cate api");
  //   }
  // }

  // static Future getAllCategory() async {
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json'
  //   };
  //   var url = Uri.https(Config.apiURL, Config.categoryAPI);

  //   var response = await client.get(
  //     url, 
  //     headers: requestHeaders,
  //   );
  //   if (response.statusCode == 200) {
  //     return Categories.fromJson(json.decode(response.body));
  //   }
  //   else {
  //     throw Exception("Failed to load cate api");
  //   }
  // }

  static Future<List<Categories>?> getAllCategory() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiURL, Config.categoryAPI);

    var response = await client.get(
      url, 
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return categoriesFromJson(response.body);
    }
    else {
      throw Exception("Failed to load cate api");
    }
  }

  static Future<List<Products>?> getAllProduct() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiURL, Config.productAPI);

    var response = await client.get(
      url, 
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    }
    else {
      throw Exception("Failed to load cate api");
    }
  }

  static Future<List<Products>?> getFeaturedProduct() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiURL, Config.featuredProductAPI);

    var response = await client.get(
      url, 
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    }
    else {
      throw Exception("Failed to load cate api");
    }
  }

  static Future<ProductDetail> getProductById(int id) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiURL, Config.productByIdAPI + id.toString());

    var response = await client.get(
      url, 
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      return productDetailFromJson(response.body);
    }
    else {
      throw Exception("Failed to load cate api");
    }
  }

  // static Future<List<Products>?> getAllFavoriteProduct() async {
  //   var loginDetails = await SharedService.loginDetails();

  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${loginDetails!.resultObj}'
  //   };

  //   var url = Uri.https(Config.apiURL, Config.productFavorite + loginDetails.resultObj!);

  //   var response = await client.get(
  //     url, 
  //     headers: requestHeaders,
  //   );
  //   if (response.statusCode == 200) {
  //     return productsFromJson(response.body);
  //   }
  //   else {
  //     throw Exception("Failed to load cate api");
  //   }
  // }

  static Future<FavoriteResponseModel> AddFavorite(FavoriteRequestModel model) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.resultObj}'
    };

    var url = Uri.https(Config.apiURL, Config.addFavorite);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return favoriteResponseModelFromJson(response.body);
  }

  static Future<FavoriteResponseModel> DeleteFavorite(FavoriteRequestModel model) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.resultObj}'
    };

    var url = Uri.https(Config.apiURL, Config.deleteFavorite);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return favoriteResponseModelFromJson(response.body);
  }
}