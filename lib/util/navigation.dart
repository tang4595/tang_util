import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

class Navigation {

  // Navigator.
  static final RouteObserver<PageRoute> routeObserver =
  RouteObserver<PageRoute>();
  static final EventBus navigationEventBus = EventBus();

  // Routes.
  /// .
  static const kRoute = '/route/path';

}

class NavigatorHelper {
  static Future push<T>(BuildContext context, Widget dest) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return dest;
        },
      ),
    );
  }

  static void pushAndRemoveUntil(BuildContext context, Widget dest) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return dest;
          },
    ), (route) {
      return true;
    });
  }

  static Future pushReplacement<T>(BuildContext context, Widget dest) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return dest;
        },
      ),
    );
  }
}