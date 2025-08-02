import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

enum SignInType { apple, google, guest }

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(super.initialState, {required IConfAuthRepository authRepository})
    : _authRepository = authRepository;
  final IConfAuthRepository _authRepository;

  Future<void> signIn(SignInType type) async {
    emit(const SignInLoadingState());
    final result = await switch (type) {
      SignInType.apple => _authRepository.signInWithApple(),
      SignInType.google => _authRepository.signInWithGoogle(),
      SignInType.guest => _authRepository.signInAnonymously(),
    };
    final newState = switch (result) {
      Success() => const SignInSuccessState(),
      Failure(:final error) when error.aborter => const SingInInitialState(),
      Failure(:final error) => SignInErrorState(error.fromException()),
    };
    emit(newState);
  }
}

extension on ConfAuthDataSourceException {
  bool get aborter => this is UserAbortedSignInException;

  SignInErrorType fromException() => switch (this) {
    NoInternetException() => SignInErrorType.internet,
    _ => SignInErrorType.generic,
  };
}
