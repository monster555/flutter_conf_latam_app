import 'dart:developer';

import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

enum SignInType { apple, google, guest }

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(super.initialState, {required IConfAuthRepository authRepository})
    : _authRepository = authRepository;
  final IConfAuthRepository _authRepository;

  Future<void> signIn(SignInType type) async {
    final userResult = await switch (type) {
      SignInType.apple => _authRepository.signInWithApple(),
      SignInType.google => _authRepository.signInWithGoogle(),
      SignInType.guest => _authRepository.signInAnonymously(),
    };
    log('Sign In with ${type.name}...', name: 'SignInCubit');
  }
}
