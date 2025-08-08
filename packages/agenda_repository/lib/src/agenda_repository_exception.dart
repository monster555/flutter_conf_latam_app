class AgendaRepositoryException implements Exception {
  AgendaRepositoryException(this.message, {this.cause});
  final String message;
  final Exception? cause;

  @override
  String toString() {
    final cause = this.cause != null ? 'Caused by: ${this.cause}' : '';
    return 'AgendaRepositoryException: $message $cause';
  }
}
