import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ColorConstant/ColorConstant.dart';

class termscondition extends StatefulWidget {
  const termscondition({Key? key}) : super(key: key);

  @override
  State<termscondition> createState() => _termsconditionState();
}

class _termsconditionState extends State<termscondition> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: [
                Positioned(
                  child: WebView(
                    initialUrl: 'https://reapp.com.gh/terms-and-condition/',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller = webViewController;
                    },
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Container(
                    //padding: const EdgeInsets.all(5),
                    height: 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: backarrow),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
