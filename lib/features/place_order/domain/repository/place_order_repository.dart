
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/place_order/data/repository/place_order_remote_repository.dart';
import 'package:liquor_ordering_system/features/place_order/domain/entity/place_order_entity.dart';

final placeOrderRepositoryProvider = Provider<IPlaceOrderRepository>(
    (ref) => ref.read(placeOrderRemoteRepositoryProvider));

abstract class IPlaceOrderRepository {
  Future<Either<Failure, String>> placeOrder(PlaceOrderEntity entity);
}
