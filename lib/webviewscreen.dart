import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

//Class stateful เรียกใช้การท างานแบบโต้ตอบ (เรียกใช้ State)
class webviewscreen extends StatefulWidget {
  final String url;
  webviewscreen({Key? key, required this.url}) : super(key: key);
  @override
  State<webviewscreen> createState() => _MyHomePageState();
}

//class state เขียน Code ภาษา dart เพอื่ รับค่าจากหน้าจอมาคา นวณและส่งคา◌่ กลับไปแสดงผล
class _MyHomePageState extends State<webviewscreen> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
          Uri.parse(widget.url)); // Use the passed URL to load content
  }

  void _intialstate() {
    setState(() {});
  }

  @override
//ส่วนออกแบบหน้าจอ
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       backgroundColor: Color.fromRGBO(175, 172, 255, 100),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
