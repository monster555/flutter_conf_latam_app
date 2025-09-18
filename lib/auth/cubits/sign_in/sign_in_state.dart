part of 'sign_in_cubit.dart';

sealed class SignInState {
  const SignInState();
}

class SingInInitialState extends SignInState {
  const SingInInitialState();
}

class SignInLoadingState extends SignInState {
  const SignInLoadingState();
}

class SignInSuccessState extends SignInState {
  const SignInSuccessState();
}

enum SignInErrorType { generic, internet }

class SignInErrorState extends SignInState {
  const SignInErrorState(this.type, {this.signInType});
  final SignInErrorType type;
  final SignInType? signInType;
}

extension SignInStateX on SignInState {
  SignInType? get signInType => switch (this) {
    SignInErrorState(:final signInType) => signInType,
    _ => null,
  };

  SignInErrorType? get type => switch (this) {
    SignInErrorState(:final type) => type,
    _ => null,
  };
}
