import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class web_view extends StatelessWidget{
final  String url;
web_view({required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
