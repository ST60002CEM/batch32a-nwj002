import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/place_order/domain/entity/place_order_entity.dart';
import 'package:liquor_ordering_system/features/place_order/domain/repository/place_order_repository.dart';

final placeOrderUseCaseProvider = Provider<PlaceOrderUsecase>((ref) {
  final placeOrderRepository = ref.watch(placeOrderRepositoryProvider);
  return PlaceOrderUsecase(placeOrderRepository: placeOrderRepository);
});

class PlaceOrderUsecase {
  final IPlaceOrderRepository placeOrderRepository;

  PlaceOrderUsecase({required this.placeOrderRepository});

  Future<Either<Failure, String>> placeOrder(PlaceOrderEntity entity) async {
    return placeOrderRepository.placeOrder(entity);
  }
}
