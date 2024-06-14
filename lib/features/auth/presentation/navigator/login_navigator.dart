import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/register_navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/view/login_view.dart';
import 'package:liquor_ordering_system/features/home/presentation/navigator/home_navigate.dart';

final loginViewNavigatorProvider = Provider((ref) => LoginViewNavigator());

class LoginViewNavigator with RegisterViewRoute, HomeViewRoute {
  void openLoginView() {
    NavigateRoute.pushRoute(const LoginView());
  }
}

mixin LoginViewRoute {
  openLoginView() {
    NavigateRoute.popAndPushRoute(const LoginView());
  }
}
