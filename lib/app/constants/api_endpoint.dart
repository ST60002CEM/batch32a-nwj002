class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.1.66:5000/api/";

  //auth routes
  static const String login = "user/login";
  static const String register = "user/create";
  static const String getMe = "user/get_single_user";
  static const String verifyUser = "user/verify";
  static const String updateUser = "user/update";

  //product routes
  static const String getAllProducts = 'product/get_all_products';
  static const String updateProduct = 'product/update_Product';

  static const String paginatonProducts = "product/pagination";
  static const int limitPage = 2;

  static const String imageUrl = 'http://192.168.1.66:5000/products/';

  //add to cart routes
  static const String addToCart = 'cart/addToCart';
  static const String getCart = 'cart/getCart';
}
