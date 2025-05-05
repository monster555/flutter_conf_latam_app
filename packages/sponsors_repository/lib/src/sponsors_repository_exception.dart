class SponsorsRepositoryException implements Exception {
  SponsorsRepositoryException(this.message, {this.cause});
  final String message;
  final Exception? cause;

  @override
  String toString() {
    final cause = this.cause != null ? 'Caused by: ${this.cause}' : '';
    return 'SponsorsRepositoryException: $message $cause';
  }
}
