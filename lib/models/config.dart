class Config {
  static const String appName = "App Shopping";
  static const String apiURL = "10.0.2.2:5001";
  // static const String apiURL = "127.0.0.1:5001";
  static const String loginAPI = "/api/Users/Authenticate";
  static const String userProfileAPI = "/api/Users/";
  static const String registerAPI = "/api/Users";
  static const String categoryAPI = "/api/Categories";
  static const String productAPI = "/api/Products";
  static const String productByIdAPI = "/api/Products/";
  static const String featuredProductAPI = "/api/Products/featured/3";
  static const String productFavorite = "/api/Users/getAllProductFavorite/";
  static const String addFavorite = "/api/Users/addProductFavorite";
  static const String deleteFavorite = "/api/Users/deleteProductFavorite";
}