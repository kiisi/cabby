import 'package:cabby/app/app_config.dart';
import 'package:cabby/app/app_prefs.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';

class SocketProvider {
  IO.Socket? _socket;
  final AppPreferences _appPreferences;
  bool _isConnected = false;

  // Map of event streams
  final Map<String, StreamController<Map<String, dynamic>>> _eventControllers = {};

  SocketProvider(this._appPreferences);

  // Initialize and connect to socket
  Future<void> init() async {
    if (_socket != null) {
      return;
    }

    final token = await _appPreferences.getAccessToken();

    if (token == null || token.isEmpty) {
      throw Exception('Cannot connect to socket: No auth token');
    }

    try {
      _socket = IO.io(
        AppConfig.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableForceNew()
            .setAuth({'token': token})
            .build(),
      );

      _setupSocketListeners();
      _socket!.connect();
    } catch (e) {
      throw Exception('Socket connection error: $e');
    }
  }

  // Setup basic socket listeners
  void _setupSocketListeners() {
    _socket!.onConnect((_) {
      print('Socket connected');
      _isConnected = true;
    });

    _socket!.onDisconnect((_) {
      print('Socket disconnected');
      _isConnected = false;
    });

    _socket!.onConnectError((error) {
      print('Socket connection error: $error');
      _isConnected = false;
    });

    _socket!.onError((error) {
      print('Socket error: $error');
    });
  }

  // Emit an event to the server
  void emitEvent(String event, Map<String, dynamic> data) {
    if (!_isConnected || _socket == null) {
      throw Exception('Socket not connected');
    }

    _socket!.emit(event, data);
  }

  // Listen to an event
  Stream<Map<String, dynamic>> listenToEvent(String event) {
    if (!_eventControllers.containsKey(event)) {
      _eventControllers[event] = StreamController<Map<String, dynamic>>.broadcast();

      // If socket exists, add the event listener
      if (_socket != null) {
        _socket!.on(event, (data) {
          if (data is Map) {
            _eventControllers[event]!.add(Map<String, dynamic>.from(data));
          } else {
            // Handle non-map data
            _eventControllers[event]!.add({'data': data});
          }
        });
      }
    }

    return _eventControllers[event]!.stream;
  }

  // Disconnect from a specific event
  void stopListeningToEvent(String event) {
    if (_socket != null) {
      _socket!.off(event);
    }

    if (_eventControllers.containsKey(event)) {
      _eventControllers[event]!.close();
      _eventControllers.remove(event);
    }
  }

  // Disconnect socket
  void disconnect() {
    if (_socket != null) {
      _socket!.disconnect();
      _socket!.dispose();
      _socket = null;
    }

    // Close all event controllers
    for (var controller in _eventControllers.values) {
      controller.close();
    }
    _eventControllers.clear();

    _isConnected = false;
  }

  // Check if socket is connected
  bool get isConnected => _isConnected;
}
