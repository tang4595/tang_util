import 'dart:async';
import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:tang_util/network/util_api.dart';
import 'package:tang_util/review/review_model.dart';

class UtilReviewHelper {
  factory UtilReviewHelper() => _getInstance();
  static UtilReviewHelper _getInstance() {
    return _instance;
  }

  static UtilReviewHelper get shared => _getInstance();
  static final UtilReviewHelper _instance = UtilReviewHelper._internal();
  UtilReviewHelper._internal();

  final _api = UtilApi();
  String? _reviewJsonUrl;
  Timer? _timer;
  UtilReviewModel? _reviewModel;
  bool _isInReview = false;
}

// Define

extension Define on UtilReviewHelper {}

// Getter

extension Getters on UtilReviewHelper {
  bool get isInReview => _isInReview;
}

// Request

extension _Request on UtilReviewHelper {
  _load() async {
    if (_reviewJsonUrl == null) return;
    final reviewInfo = await _api.getReviewInfo(_reviewJsonUrl ?? '');
    _reviewModel = reviewInfo;
    final version = (await PackageInfo.fromPlatform()).version;
    _isInReview = version == (_reviewModel?.latest ?? '');
  }
}

// Private

extension _Private on UtilReviewHelper {
  _runMonitor() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_reviewModel != null) {
        _stopMonitor();
        return;
      }
      _load();
    });
  }

  _stopMonitor() {
    _timer?.cancel();
    _timer = null;
  }
}

// Action

extension _Actions on UtilReviewHelper {}

// Public

extension Public on UtilReviewHelper {
  setup({required String reviewJsonUrl}) async {
    _reviewJsonUrl = reviewJsonUrl;
    if (!Platform.isAndroid) return;
    _load();
    _runMonitor();
  }
}
