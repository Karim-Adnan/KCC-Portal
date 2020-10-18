import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  final title;
  WebViewContainer(this.url, this.title);
  @override
  createState() => _WebViewContainerState(this.url, this.title);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  var _title;
  final _key = UniqueKey();
  num position = 1 ;
  _WebViewContainerState(this._url, this._title);
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }
  startLoading(String A){
    setState(() {
      position = 1;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(_title)),
        backgroundColor: Color(0xff1dc4d8),
        body: IndexedStack(
            index: position,
            children: <Widget>[
              WebView(
                userAgent: "random",
                initialUrl: _url,
                javascriptMode: JavascriptMode.unrestricted,
                key: _key ,
                onPageFinished: doneLoading,
                onPageStarted: startLoading,
              ),
              Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator()),
              ),
            ]
        )
    );
  }
}
