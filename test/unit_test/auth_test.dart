import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/domain/usecases/auth_use_case.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/login_navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/navigator/register_navigator.dart';
import 'package:liquor_ordering_system/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  MockSpec<RegisterViewNavigator>(),

])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;


  setUp(
    () {
      mockAuthUsecase = MockAuthUseCase();
      mockLoginViewNavigator = MockLoginViewNavigator();
      container = ProviderContainer(
        overrides: [
          authViewModelProvider.overrideWith(
              (ref) => AuthViewModel(mockLoginViewNavigator, mockAuthUsecase))
        ],
      );
    },
  );
  test("check for the initial state in the auth state", () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  test('loggin test with valid username and password', () async {

    //arrange
    const correctUsername = 'nwj';
    const correctPassword = 'nwj123';

    when(mockAuthUsecase.loginUser('nwj', 'nwj123')).thenAnswer((invocation) {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
          username == correctUsername && password == correctPassword
              ? const Right(true)
              : Left(Failure(error: 'Invalid')));
    });
    //act
    await container
        .read(authViewModelProvider.notifier)
        .loginUser('nwj', 'nwj123');

    final authState = container.read(authViewModelProvider);

    //assert
    expect(authState.error, isNull);
  });

  tearDown(
    () {
      container.dispose();
    },
  );
}
