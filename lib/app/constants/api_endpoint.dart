class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.137.80:5000/api/";

  //auth routes
  static const String login = "user/login";
  static const String register = "user/create";

  //product routes
  static const String products = "product/pagination";
}
