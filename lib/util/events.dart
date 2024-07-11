class HandleNotificationEvent {
  final String? method;
  final dynamic arguments;
  HandleNotificationEvent(this.method, this.arguments);
}

class NavigationDidPushEvent {
  final String routeCurrent;
  final String routePrevious;
  NavigationDidPushEvent(this.routeCurrent, this.routePrevious);
}

class NavigationDidPopEvent {
  final String routeCurrent;
  final String routePrevious;
  NavigationDidPopEvent(this.routeCurrent, this.routePrevious);
}

class TokenExpiredEvent {}

class HandleUserEvent extends HandleNotificationEvent {
  HandleUserEvent(dynamic user) : super('', user);
}