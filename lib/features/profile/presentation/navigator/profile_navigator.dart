import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/profile/presentation/view/profile_view.dart';

final profileNavigatorProvider = Provider<ProfileNavigator>((ref) {
  return ProfileNavigator();
});

class ProfileNavigator with LoginViewRoute {}

mixin ProfileRoute {
  openProfile() {
    NavigateRoute.popAndPushRoute(const ProfileView());
  }
}
