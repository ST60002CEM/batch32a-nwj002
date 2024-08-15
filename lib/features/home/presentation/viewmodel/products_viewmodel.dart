import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/features/cart/domain/entity/cart_entity.dart';
import 'package:liquor_ordering_system/features/cart/domain/usecases/cart_usecase.dart';
import 'package:liquor_ordering_system/features/home/domain/usecases/product_usecase.dart';
import 'package:liquor_ordering_system/features/home/presentation/state/product_state.dart';

final productViewModelProvider =
    StateNotifierProvider<ProductViewModel, ProductState>(
        (ref) => ProductViewModel(
              productUsecase: ref.read(productUsecaseProvider),
              cartUseCase: ref.read(cartUsecaseProvider),
            ));

class ProductViewModel extends StateNotifier<ProductState> {
  ProductViewModel({
    required this.productUsecase,
    required this.cartUseCase,
  }) : super(ProductState.initial()) {
    getProducts();
  }

  final ProductUseCase productUsecase;
  final CartUsecase cartUseCase;

  Future resetState() async {
    state = ProductState.initial();
    await getProducts();
  }

  Future getProducts() async {
    state = state.copyWith(isLoading: true);
    final currentState = state;
    final page = currentState.page + 1;
    final products = currentState.products;
    final hasReachedMax = currentState.hasReachedMax;
    if (!hasReachedMax) {
      // get data from data source
      final result = await productUsecase.pagination(page, 2);
      result.fold(
        (failure) => state = state.copyWith(
          hasReachedMax: true,
          isLoading: false,
          error: failure.error,
        ),
        (data) {
          if (data.isEmpty) {
            state = state.copyWith(hasReachedMax: true);
          } else {
            state = state.copyWith(
              products: [...products, ...data],
              page: page,
              isLoading: false,
            );
          }
        },
      );
    } else {
      state = state.copyWith(isLoading: false);
      mySnackBar(message: 'No more data');
    }
  }

  Future<void> addToCart(CartEntity cartEntity) async {
    state = state.copyWith(isLoading: true);
    final result = await cartUseCase.addToCart(cartEntity);
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (data) {
        state = state.copyWith(isLoading: false);
      },
    );
  }
}
