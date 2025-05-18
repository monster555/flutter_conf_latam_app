/// Base exception for all data source exceptions.
class ConfDataSourceException implements Exception {
  const ConfDataSourceException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() =>
      'ConfDataSourceException: $message${cause != null ? ' ($cause)' : ''}';
}
