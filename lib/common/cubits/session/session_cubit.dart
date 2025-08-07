import 'package:conf_auth_repository/conf_auth_repository.dart';
import 'package:conf_shared_models/conf_shared_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(
    super.initialState, {
    required IConfAuthRepository authRepository,
    required IUserRepository userRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository;

  final IConfAuthRepository _authRepository;
  final IUserRepository _userRepository;

  Future<void> checkSession() async {
    final checkingState = switch (state) {
      SessionAuthenticated() || SessionIncompleteProfile() => state,
      _ => const CheckingSession(),
    };
    emit(checkingState);
    final user = _authRepository.currentUser;
    final newState = switch (user) {
      null => const SessionUnauthenticated(),
      final ConfAuthUser user when user.isAnonymous =>
        const SessionAuthenticated(),
      final ConfAuthUser user => await _checkProfileUser(user.id),
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

  Future<SessionState> _checkProfileUser(String id) async {
    final result = await _userRepository.get(id);
    return switch (result) {
      Success(data: final user) => SessionAuthenticated(user: user),
      Failure() => const SessionIncompleteProfile(),
    };
  }

  void updateUser(User user) => emit(SessionAuthenticated(user: user));
}
