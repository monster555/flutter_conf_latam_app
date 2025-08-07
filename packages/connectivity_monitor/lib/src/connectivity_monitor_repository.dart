import 'dart:async';
import 'dart:io';

import 'package:connectivity_monitor/connectivity_monitor.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Default implementation of [IConnectivityMonitorRepository] using
/// connectivity_plus and ping.
class ConnectivityMonitorRepository implements IConnectivityMonitorRepository {
  ConnectivityMonitorRepository({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  StreamController<ConnectionStatus>? _streamController;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _initialized = false;

  @override
  Stream<ConnectionStatus> get stream {
    _streamController ??= StreamController<ConnectionStatus>.broadcast();
    return _streamController!.stream;
  }

  @override
  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    final initial = await _getStatus();
    _emit(initial);

    _subscription = _connectivity.onConnectivityChanged.listen(_onData);
  }

  @override
  Future<bool> connected() => _hasInternet();

  Future<void> _onData(List<ConnectivityResult> results) async {
    if (results.isEmpty || results.every((r) => r == ConnectivityResult.none)) {
      _emit(ConnectionStatus.disconnected);
      return;
    }

    final status = await _getStatus();
    _emit(status);
  }

  Future<ConnectionStatus> _getStatus() async {
    final result = await _hasInternet();
    return result ? ConnectionStatus.connected : ConnectionStatus.disconnected;
  }

  void _emit(ConnectionStatus status) {
    if (_streamController?.isClosed ?? true) return;
    _streamController?.add(status);
  }

  Future<bool> _hasInternet() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _streamController?.close();
  }
}
