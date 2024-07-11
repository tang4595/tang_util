import 'package:flutter/material.dart';
import 'package:tang_appbase/tang_appbase.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UtilWebPage extends StatefulWidget {
  final String? title;
  final String url;
  final Color backgroundColor;

  const UtilWebPage({
    super.key,
    this.title,
    required this.url,
    this.backgroundColor = Colors.white,
  });

  @override
  //ignore: no_logic_in_create_state
  createState() => _UtilWebPageState(
    url: url,
    backgroundColor: backgroundColor,
    title: title,
  );
}

class _UtilWebPageState extends State<UtilWebPage> {

  String url;
  Color backgroundColor;
  String? title;

  final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

  _UtilWebPageState({
    required this.url,
    required this.backgroundColor,
    this.title,
  });

  @override
  void initState() {
    super.initState();
    _controller.setBackgroundColor(backgroundColor);
    Future.delayed(const Duration(milliseconds: 300), () {
      _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}

// Private

extension _Private on _UtilWebPageState {

  _load() {
    _controller.loadRequest(Uri.parse(url));
  }
}