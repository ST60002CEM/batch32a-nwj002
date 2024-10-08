import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/cart_entity.dart';
import 'package:liquor_ordering_system/features/home/domain/usecases/cart_usecase.dart';
import 'package:liquor_ordering_system/features/home/presentation/state/cart_state.dart';

final cartViewModelProvider =
    StateNotifierProvider<CartViewModel, CartState>((ref) => CartViewModel(
          cartUsecase: ref.watch(cartUsecaseProvider),
          userSharedPrefs: ref.watch(userSharedPrefsProvider),
          
          // navigator: ref.watch(cartViewNavigatorProvider),
        ));

class CartViewModel extends StateNotifier<CartState> {
  CartViewModel({
    required this.cartUsecase,
    required this.userSharedPrefs,
    // required this.navigator,
  }) : super(CartState.initial());

  final CartUsecase cartUsecase;
  final UserSharedPrefs userSharedPrefs;
  // final CartViewNavigator navigator;

  //get cart
  Future<void> getCarts() async {
    state = state.copyWith(isLoading: true);
    final result = await cartUsecase.getCarts();
    var data = await cartUsecase.getCarts();
    data.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      // showMySnackBar(message: failure.error, color: Colors.red);
    }, (success) {
      state = state.copyWith(isLoading: false, error: null, products: success);
      // showMySnackBar(message: 'Cart fetched successfully', color: Colors.green);
    });
  }

  //add cart
  Future<void> addCart(String userID, String productID, int quantity) async {
    state = state.copyWith(isLoading: true);
    final result = await cartUsecase.addCart(userID, productID, quantity);
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
      // showMySnackBar(message: failure.error, color: Colors.red);
    }, (success) {
      state = state.copyWith(
        isLoading: false,
        error: null,
      );
      // showMySnackBar(message: 'Product added to cart', color: Colors.green);
    });
    getCarts();
  }

  // openCheckoutScreen() {
  //   navigator.openPlaceOrderView(state.products);
  // }
}
