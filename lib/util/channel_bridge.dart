import 'package:flutter/services.dart';
import 'dart:async';
import 'package:event_bus/event_bus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tang_util/util/events.dart';

class ChannelBridge {
  factory ChannelBridge() => _getInstance();
  static ChannelBridge _getInstance() { return _instance; }
  static ChannelBridge get shared => _getInstance();
  static final ChannelBridge _instance = ChannelBridge._internal();
  static final EventBus notificationEventBus = EventBus();
  static String? packageName;

  ChannelBridge._internal() {
    // init...
    _signalSetup();
  }

  static const navigationPopChannel = MethodChannel('com.util.method.navigation.pop');
  static const navigationPushChannel = MethodChannel('com.util.method.navigation.push');
  static const notificationChannel = MethodChannel('com.util.method.common');

  _signalSetup() {
    notificationChannel.setMethodCallHandler(_notificationChannelHandler);
  }

  Future<dynamic> _notificationChannelHandler(MethodCall methodCall) {
    notificationEventBus.fire(HandleNotificationEvent(methodCall.method, methodCall.arguments));
    return Future.value(true);
  }

  // Methods.
  static navigationPop() {
    navigationPopChannel.invokeMethod('');
  }

  static navigationPush(String path) {
    navigationPushChannel.invokeMethod(path);
  }
}

// Define

abstract class ChannelNotificationEvent {
  final String module;
  final String action;
  final List<dynamic>? arguments;

  ChannelNotificationEvent({
    required this.module,
    required this.action,
    this.arguments
  });
}

// Public

extension PublicOfChannelBridge on ChannelBridge {

  setup() async {
    ChannelBridge.shared.toString();
    ChannelBridge.packageName = (await PackageInfo.fromPlatform()).packageName;
  }

  Future<T?> postNotification<T>(ChannelNotificationEvent event) {
    if (event.module.isEmpty || event.action.isEmpty) return Future.value(null);
    final method = '${ChannelBridge.packageName}'
        '.${event.module}'
        '.${event.action}';
    return ChannelBridge.notificationChannel.invokeMethod(
      method,
      event.arguments,
    );
  }
}