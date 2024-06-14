import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

class SplashViewNavigator with LoginViewRoute {}

mixin SplashViewRoute {}
