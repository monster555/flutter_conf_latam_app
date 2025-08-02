import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(
    super.initialState, {
    required IConfAuthRepository authRepository,
  }) : _authRepository = authRepository;

  final IConfAuthRepository _authRepository;

  Future<void> checkSession() async {
    emit(const CheckingSession());
    final user = _authRepository.currentUser;
    final newState = switch (user) {
      final ConfAuthUser user when user.isAnonymous => SessionAuthenticated(
        user,
      ),
      final ConfAuthUser user => SessionIncompleteProfile(user),
      null => const SessionUnauthenticated(),
    };
    emit(newState);
  }

  Future<void> logout() async {
    final result = await _authRepository.signOut();
    final newState = switch (result) {
      Success() => const SessionUnauthenticated(),
      Failure() => state,
    };
    emit(newState);
  }
}
