import 'package:flutter/foundation.dart';

// ignore_for_file: avoid_print

logInfo(Object object) {
  if (kReleaseMode) return;
  print('♻️ $object');
}

logWarn(Object object) {
  print('⚠️️ $object');
}

logError(Object object) {
  print('❌️ $object');
}