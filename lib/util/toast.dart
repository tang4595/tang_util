import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oktoast/oktoast.dart';
import 'dart:async';

class Toast {

  static const double actionSheetItemHeight = 54.0;
  static const double actionSheetSeparatorHeight = 10.0;
  static bool isLoading = false;

  static localizedInfo(String? content) {
    if (null == content) { return; }
    showToast(content);
  }

  static info(String? content) {
    if (null == content) { return; }
    showToast(content);
  }

  /// The Confirmable info-alert with customizable confirm button and
  /// cancel button.
  static Future<bool> confirmAlert({
    required BuildContext context,
    required String content,
    String? title,
    Color? titleColor,
    Color? contentColor,
    String? confirmButtonTitle,
    bool showCancel = true,
    bool cupertinoStyle = false,
  }) {
    final completer = Completer<bool>();
    if (cupertinoStyle) {
      CupertinoAlertDialog dialog = CupertinoAlertDialog(
        title: (null != title && title.isEmpty)
            ? null
            : (null == titleColor
            ? Text(title ?? '提示')
            : Text(
          title ?? '提示',
          style: TextStyle(color: titleColor),
        )),
        content: SingleChildScrollView(
          child: (null == contentColor
              ? Text(content)
              : Text(
            content,
            style: TextStyle(color: contentColor),
          )),
        ),
        actions: <Widget>[
          showCancel ?
          TextButton(
            child: const Text(
              '取消',
              style: TextStyle(color: Colors.redAccent),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(Future<bool>.value(false));
            },
          ):const SizedBox(width: 0.01),
          TextButton(
            child: Text(confirmButtonTitle ?? '确定'),
            onPressed: () {
              Navigator.of(context).pop();
              completer.complete(Future<bool>.value(true));
            },
          ),
        ],
      );
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return dialog;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: (null != title && title.isEmpty)
                ? null
                : (null == titleColor
                ? Text(title ?? '提示')
                : Text(
              title ?? '提示',
              style: TextStyle(color: titleColor),
            )),
            content: SingleChildScrollView(
              child: (null == contentColor
                  ? Text(content)
                  : Text(
                content,
                style: TextStyle(color: contentColor),
              )),
            ),
            actions: <Widget>[
              showCancel ?
              TextButton(
                child: const Text(
                  '取消',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  completer.complete(Future<bool>.value(false));
                },
              ):const SizedBox(width: 0.01),
              TextButton(
                child: Text(confirmButtonTitle ?? '确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  completer.complete(Future<bool>.value(true));
                },
              ),
            ],
          );
        },
      );
    }
    return completer.future;
  }

  /// The ActionSheet just like the appearance on the Platform iOS.
  static Future<int> showActionSheet(BuildContext context, {
    required List<String> actions,
  }) {
    final completer = Completer<int>();
    showModalBottomSheet(context: context, builder: (BuildContext context) {

      return SafeArea(
        child: Container(
          color: Colors.white60,
          height: Toast.actionSheetItemHeight*(actions.length + 1) +
              Toast.actionSheetSeparatorHeight,
          child: ListView.builder(
            itemCount: actions.length + 1,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int position) {

              if (position == actions.length) {

                // The Cancel Button.
                return InkWell(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                    color: Colors.white70,///Config.themeColorSeparator,
                    width: MediaQuery.of(context).size.width,
                    height: Toast.actionSheetItemHeight,
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '取消',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    completer.complete(Future<int>.value(-1));
                  },
                );
              } else {

                // The Actions.
                return InkWell(
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,///Config.themeColorSeparator,
                        width: MediaQuery.of(context).size.width,
                        height: Toast.actionSheetItemHeight,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              actions[position],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 1.0),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    completer.complete(Future<int>.value(position));
                  },
                );
              }
            },
          ),
        ),
      );
    });
    return completer.future;
  }

  static showLoading(BuildContext context, {
    int hideDelay = 16,
    VoidCallback? onTimeout,
    VoidCallback? onTimeoutDismissed,
  }) {
    if (Toast.isLoading) return;
    Toast.isLoading = true;
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: const Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
              ),
            ),
          );
        }
    );
    Future.delayed(Duration(seconds: hideDelay), () {
      if (onTimeout != null) onTimeout();
      hideLoading(context).then((_) {
        if (onTimeoutDismissed != null) onTimeoutDismissed();
      });
    });
  }

  static Future<void> hideLoading(BuildContext context) async {
    if (!Toast.isLoading) return Future.value();
    Toast.isLoading = false;
    Navigator.of(context).pop();
    return await Future.delayed(const Duration(milliseconds: 300));
  }
}