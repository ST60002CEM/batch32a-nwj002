import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/home/presentation/navigator/home_navigate.dart';
import 'package:liquor_ordering_system/features/place_order/domain/entity/place_order_entity.dart';
import 'package:liquor_ordering_system/features/place_order/domain/usecases/place_order_usecase.dart';
import 'package:liquor_ordering_system/features/place_order/presentation/state/place_order_state.dart';

// Provider for PlaceOrderViewModel
final placeOrderViewModelProvider =
    StateNotifierProvider<PlaceOrderViewModel, PlaceOrderState>(
  (ref) => PlaceOrderViewModel(
    placeOrderUseCase: ref.watch(placeOrderUseCaseProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
    navigator: ref.watch(homeViewNavigatorProvider),
  ),
);

class PlaceOrderViewModel extends StateNotifier<PlaceOrderState> {
  PlaceOrderViewModel({
    required this.placeOrderUseCase,
    required this.userSharedPrefs,
    required this.navigator,
  }) : super(PlaceOrderState.initial());

  final PlaceOrderUsecase placeOrderUseCase;
  final UserSharedPrefs userSharedPrefs;
  final HomeViewNavigator navigator;

  // Place an order
  Future<void> placeOrder(
    PlaceOrderEntity placeOrderEntity,
  ) async {
    state = state.copyWith(isLoading: true);
    final result = await placeOrderUseCase.placeOrder(
      placeOrderEntity,
    );

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        // SnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          placeOrder: success,
        );
        // If placing the order is successful, initialize Khalti payment
      },
    );
  }
}
