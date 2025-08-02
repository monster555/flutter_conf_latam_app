part of 'session_cubit.dart';

sealed class SessionState {
  const SessionState();
}

class CheckingSession extends SessionState {
  const CheckingSession();
}

class SessionAuthenticated extends SessionState {
  const SessionAuthenticated(this.user);
  final ConfAuthUser user;
}

class SessionIncompleteProfile extends SessionState {
  const SessionIncompleteProfile(this.user);
  final ConfAuthUser user;
}

class SessionUnauthenticated extends SessionState {
  const SessionUnauthenticated();
}
