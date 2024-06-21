class ApiEndpoints {
  ApiEndpoints._();
  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 3000);
  static const String baseUrl = "http://192.168.1.66:5000/api/";

  //auth routes
  static const String login = "user/login";
  static const String register = "user/create";
}
