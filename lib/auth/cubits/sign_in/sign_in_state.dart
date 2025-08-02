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
  const SignInErrorState(this.type);
  final SignInErrorType type;
}
