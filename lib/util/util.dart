import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ValueChanged1 = Function(dynamic value);
typedef ValueChanged2 = Function(dynamic value1, dynamic value2);
typedef ValueChanged3 = Function(dynamic value1, dynamic value2,
    dynamic value3);
typedef ValueChanged4 = Function(dynamic value1, dynamic value2,
    dynamic value3, dynamic value4);
typedef ValueChanged5 = Function(dynamic value1, dynamic value2,
    dynamic value3, dynamic value4, dynamic value5);

/// Time Display
String prettyTime({
  int seconds = 0,
  int total = 0,
}) {
  int h = seconds~/3600;
  int m = seconds~/60;
  int s = seconds%60;
  String hs = 3600 > total ? '':'${h < 10 ? '0$h' : '$h'}:';
  String ms = 60 > total ? '':'${m < 10 ? '0$m' : '$m'}:';
  String ss = s < 10 ? '0$s' : '$s';
  return '$hs$ms$ss';
}

/// String
extension StringExt on String {
  String md5enc() {
    var content = const Utf8Encoder().convert(this);
    var digest = md5.convert(content);
    return digest.toString();
  }

  dynamic toJson() => jsonDecode(this);
  Map<String, dynamic>? toJsonMap() => jsonDecode(this) as Map<String, dynamic>;

  String rootImageRes() => 'res/images/$this.png';
  String rootImageResJpeg() => 'res/images/$this.jpg';
  String rootImageResWebp() => 'res/images/$this.webp';

  String maskedTel({int head = 3, int tail = 4, String mask = '****'}) {
    if (length <= (head + tail)) return this;
    return '${substring(0, head)}'
        '****'
        '${substring(length - tail, length)}';
  }
}

/// Int
extension IntExt on int {
  String prettyStorageUnit() {
    var kb = this;
    if (kb < 1000) return 'KB';
    if (kb < 1048576) return 'MB';
    return 'GB';
  }

  String prettyStorageSize() {
    var kb = this;
    if (kb < 1000) return '${kb.toStringAsFixed(0)}KB';
    if (kb < 1048576) return '${(kb/1024).toStringAsFixed(1)}MB';
    return '${(kb/1024/1024).toStringAsFixed(2)}GB';
  }

  String prettyStorageSizeWithoutUnit() {
    return prettyStorageSize()
        .replaceAll('KB', '')
        .replaceAll('MB', '')
        .replaceAll('GB', '');
  }

  String num2str() {
    switch (this) {
      case 0: return '零';
      case 1: return '一';
      case 2: return '二';
      case 3: return '三';
      case 4: return '四';
      case 5: return '五';
      case 6: return '六';
      case 7: return '七';
      case 8: return '八';
      case 9: return '九';
      case 10: return '十';
      case 11: return '十一';
      case 12: return '十二';
      case 13: return '十三';
      case 14: return '十四';
      case 15: return '十五';
      case 16: return '十六';
      case 17: return '十七';
      case 18: return '十八';
      case 19: return '十九';
      case 20: return '二十';
    }
    return '';
  }

  String secondsToTime() {
    int h = this ~/ 3600;
    int m = (this % 3600) ~/ 60;
    int s = this % 60;
    return '${h < 10 ? '0$h' : h}:${m < 10 ? '0$m' : m}:${s < 10 ? '0$s' : s}';
  }
}

/// Num
extension NumExt on num {
  num adapterW() {
    return ScreenUtil().setWidth(this);
  }

  num adapterH() {
    return ScreenUtil().setHeight(this);
  }

  num adapterFS() {
    return ScreenUtil().setSp(this);
  }
}

extension MapEx on Map {
  String toJsonStr() => (const JsonEncoder()).convert(this);
}

/// Screen Size

class Screen {
  static Orientation get orientation => ScreenUtil().orientation;
  static num get width => ScreenUtil().screenWidth;
  static num get height => ScreenUtil().screenHeight;
  static num get statusBarHeight => ScreenUtil().statusBarHeight;
  static num get bottomBarHeight => ScreenUtil().bottomBarHeight;
}