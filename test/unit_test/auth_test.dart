import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquor_ordering_system/core/failure/failure.dart';
import 'package:liquor_ordering_system/features/auth/domain/entity/auth_entity.dart';
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

  test('login test with valid username and password', () async {
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

  test(
    'Register new user test with all details test',
    () async {
      // Arrange
      when(mockAuthUsecase.registerUser(const AuthEntity(
        fullname: 'nawaraj',
        username: 'nwj',
        email: 'nwj@gmail.com',
        password: '12345678',
        age: '18',
      ))).thenAnswer((innovation) {
        final auth = innovation.positionalArguments[0] as AuthEntity;

        return Future.value(
          auth.fullname.isNotEmpty &&
                  auth.username.isNotEmpty &&
                  auth.email.isNotEmpty &&
                  auth.password.isNotEmpty &&
                  auth.email.contains('@') &&
                  auth.email.contains('.') &&
                  auth.age.isNotEmpty
              ? const Right(true)
              : Left(
                  Failure(error: 'Invalid'),
                ),
        );
      });

      // Act
      await container
          .read(authViewModelProvider.notifier)
          .registerUser(const AuthEntity(
            fullname: 'nawaraj',
            username: 'nwj',
            email: 'nwj@gmail.com',
            password: '12345678',
            age: '18',
          ));

      final state = container.read(authViewModelProvider);

      // Assert
      expect(state.isLoading, false);
      expect(state.error, null);
    },
  );

  // test("register with user credientials", () async {
  //   when(mockAuthUsecase.registerUser(any))
  //       .thenAnswer((_) => Future.value(const Right(true)));

  //   const AuthEntity user = AuthEntity(
  //     fullname: 'nawaraj',
  //     username: 'nwj',
  //     email: 'nwj@gmail.com',
  //     password: '12345678',
  //     age: '18',
  //   );
  //   await container.read(authViewModelProvider.notifier).registerUser(user);
  //   final authState = container.read(authViewModelProvider);
  //   // Assert
  //   expect(authState.error, isNull);
  // });

  tearDown(
    () {
      container.dispose();
    },
  );
}
