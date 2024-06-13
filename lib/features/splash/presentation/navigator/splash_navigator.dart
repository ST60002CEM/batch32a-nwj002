import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewNavigatorProvider =
    Provider<SplashViewNavigator>((ref) => SplashViewNavigator());

class SplashViewNavigator with SplashViewRoute {}

mixin SplashViewRoute {}
