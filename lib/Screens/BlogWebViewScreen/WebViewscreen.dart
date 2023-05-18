import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ColorConstant/ColorConstant.dart';

class Webviewscreen extends StatefulWidget {
  const Webviewscreen({Key? key}) : super(key: key);

  @override
  State<Webviewscreen> createState() => _WebviewscreenState();
}

class _WebviewscreenState extends State<Webviewscreen> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          child: WebView(
            initialUrl: 'https://reapp.com.gh/blog/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          ),
        ),
        // Positioned(
        //   top: 20,
        //   left: 10,
        //   child:
        //   Container(
        //     //padding: const EdgeInsets.all(5),
        //     height: 40,
        //     decoration:
        //         const BoxDecoration(shape: BoxShape.circle, color: backarrow),
        //     child: Center(
        //       child: IconButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         icon: const Icon(
        //           Icons.arrow_back,
        //           color: Colors.white,
        //           size: 25,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
