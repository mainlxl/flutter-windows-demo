import 'dart:async';

import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  SecondPageState createState() => SecondPageState();
}

class SecondPageState extends State<SecondPage> {
  Timer? _timer; // 定时器

  void startTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(const Duration(seconds: 2), (timer) {});
    } else {
      _timer?.cancel(); // 停止定时器
      _timer = null;
    }
  }

  void stopTimer() {
    _timer?.cancel(); // 停止定时器
  }

  @override
  void dispose() {
    stopTimer(); // 确保在页面销毁时停止定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('检测前后台'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            startTimer();
          },
          child: const Text('检测windows前后台'),
        ),
      ),
    );
  }
}
