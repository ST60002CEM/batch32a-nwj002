import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/navigator/navigator.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';
import 'package:liquor_ordering_system/features/home/presentation/navigator/home_navigate.dart';
import 'package:liquor_ordering_system/features/place_order/presentation/view/chekout_view.dart';

final placeOrderViewNavigatorProvider =
    Provider((ref) => PlaceOrderViewNavigator());

class PlaceOrderViewNavigator with HomeViewRoute {}

mixin PlaceOrderViewRoute {
  void openPlaceOrderView(List<CartEntity> carts) {
    NavigateRoute.pushRoute(CheckoutScreen(
      cartItems: carts,
    ));
  }
}
