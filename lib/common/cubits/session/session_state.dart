part of 'session_cubit.dart';

sealed class SessionState {
  const SessionState();
}

class CheckingSession extends SessionState {
  const CheckingSession();
}

class SessionAuthenticated extends SessionState {
  const SessionAuthenticated({this.user});
  final User? user;
}

class SessionIncompleteProfile extends SessionState {
  const SessionIncompleteProfile();
}

class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}

extension SessionStateX on SessionState {
  User? get user => switch (this) {
    SessionAuthenticated(:final user) => user,
    _ => null,
  };
}
