import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatelessWidget {
  final String blogUrl;

  ArticleView({required this.blogUrl});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = _createWebViewController();

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(controller),
    );
  }

  WebViewController _createWebViewController() {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(blogUrl));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _buildAppBarTitle(),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Flutter"),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildBody(WebViewController controller) {
    return WebViewWidget(controller: controller);
  }
}
