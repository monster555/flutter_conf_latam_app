import 'package:connectivity_monitor/connectivity_monitor.dart';

/// Defines the contract for monitoring internet connectivity.
abstract interface class IConnectivityMonitorRepository {
  /// Starts the monitor and emits real-time updates.
  Future<void> initialize();

  Future<bool> connected();

  /// Stream to listen to status updates.
  Stream<ConnectionStatus> get stream;

  /// Disposes the internal stream/subscriptions.
  void dispose();
}
