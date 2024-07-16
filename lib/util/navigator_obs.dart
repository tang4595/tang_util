import 'package:flutter/material.dart';
import 'package:tang_util/util/events.dart';
import 'package:tang_util/util/navigation.dart';

class AppGlobalNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    String? previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    } else {
      previousName = previousRoute.settings.name;
    }
    Navigation.navigationEventBus.fire(NavigationDidPushEvent(
      route.settings.name ?? '',
      previousName ?? '',
    ));

    /**
    // Umeng.
    if (previousRoute?.settings?.name != null) {
      UmengAnalyticsPlugin.pageEnd(previousRoute.settings.name);
    }
    if (route?.settings?.name != null) {
      UmengAnalyticsPlugin.pageStart(route.settings.name);
    }*/
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    String? previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    } else {
      previousName = previousRoute.settings.name;
    }
    Navigation.navigationEventBus.fire(NavigationDidPopEvent(
      route.settings.name ?? '',
      previousName ?? '',
    ));

    /**
    // Umeng.
    if (route?.settings?.name != null) {
      UmengAnalyticsPlugin.pageEnd(route.settings.name);
    }
    if (previousRoute?.settings?.name != null) {
      UmengAnalyticsPlugin.pageStart(previousRoute.settings.name);
    }*/
  }

/**
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // Umeng.
    if (oldRoute?.settings?.name != null) {
      UmengAnalyticsPlugin.pageEnd(oldRoute.settings.name);
    }
    if (newRoute?.settings?.name != null) {
      UmengAnalyticsPlugin.pageStart(newRoute.settings.name);
    }
  }*/
}