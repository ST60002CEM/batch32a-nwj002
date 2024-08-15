import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/core/shared_prefs/user_shared_prefs.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
import 'package:liquor_ordering_system/features/auth/domain/repository/auth_repository.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    authRepository: ref.watch(authRepositoryProvider),
    userSharedPrefs: ref.watch(userSharedPrefsProvider),
  );
});

class AuthUseCase {
  final IAuthRepository authRepository;
  final UserSharedPrefs userSharedPrefs;

  AuthUseCase({required this.authRepository, required this.userSharedPrefs});

  Future<Either<Failure, bool>> registerUser(AuthEntity? auth) {
    return authRepository.registerUser(auth ?? const AuthEntity.empty());
  }

  Future<Either<Failure, bool>> loginUser(String? email, String? password) {
    return authRepository.loginUser(email ?? '', password ?? '');
  }

  Future<Either<Failure, bool>> verifyUser() {
    return authRepository.verifyUser();
  }

  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return authRepository.getCurrentUser();
  }

  Future<Either<Failure, bool>> updateUser(AuthEntity user) async {
    return await authRepository.updateUser(user);
  }
}
