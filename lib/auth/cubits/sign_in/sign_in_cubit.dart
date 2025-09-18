import 'package:conf_auth_data_source/conf_auth_data_source.dart';
import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:connectivity_monitor/connectivity_monitor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

enum SignInType { apple, google, guest }

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(
    super.initialState, {
    required IConfAuthRepository authRepository,
    required IConnectivityMonitorRepository monitorRepository,
  }) : _authRepository = authRepository,
       _monitorRepository = monitorRepository;
  final IConfAuthRepository _authRepository;
  final IConnectivityMonitorRepository _monitorRepository;

  FutureAuthResult<ConfAuthUser> signIn(SignInType type) async {
    emit(const SignInLoadingState());
    final connected = await _monitorRepository.connected();
    if (!connected) {
      emit(SignInErrorState(SignInErrorType.internet, signInType: type));
      return const Failure(NoInternetException());
    }
    final result = await switch (type) {
      SignInType.apple => _authRepository.signInWithApple(),
      SignInType.google => _authRepository.signInWithGoogle(),
      SignInType.guest => _authRepository.signInAnonymously(),
    };
    final newState = switch (result) {
      Success() => const SignInSuccessState(),
      Failure(:final error) when error.aborter => const SingInInitialState(),
      Failure(:final error) => SignInErrorState(
        error.fromException(),
        signInType: type,
      ),
    };
    emit(newState);
    return result;
  }

  @override
  Future<void> close() {
    _monitorRepository.dispose();
    return super.close();
  }
}

extension on ConfAuthDataSourceException {
  bool get aborter => this is UserAbortedSignInException;

  SignInErrorType fromException() => switch (this) {
    NoInternetException() => SignInErrorType.internet,
    _ => SignInErrorType.generic,
  };
}
