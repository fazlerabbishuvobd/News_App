import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenNewsUrlView extends StatefulWidget {
  const OpenNewsUrlView({super.key});

  @override
  State<OpenNewsUrlView> createState() => _OpenNewsUrlViewState();
}

class _OpenNewsUrlViewState extends State<OpenNewsUrlView> {

  String newsUrl = Get.arguments[0];
  String newsSource= Get.arguments[1];

  var loadingPercentage = 0;
  late final WebViewController webViewController;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(Uri.parse(newsUrl));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsSource),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: webViewController,
          ),
          if (loadingPercentage < 100)

            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),

          Visibility(visible: loadingPercentage==100?false:true,
            child: const SpinKitWave(
              color: Colors.amber,
              size: 50.0,),
          )
        ],
      ),
    );
  }
}
