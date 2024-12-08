import 'package:doctor/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../models/counter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.dialpad),
            onPressed: () async {
              context.pushPage("dialog");
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_chart),
            onPressed: () {
              AppRouter.pushPage(context, "chart");
            },
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => Counter(), // 创建 Counter 实例并提供
        child: Center(
          child: Consumer<Counter>(
            builder: (context, counter, child) {
              return Text(
                'Count: ${counter.count}',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
        child: const Icon(Icons.add_alarm),
      ),
    );
  }

  @override
  void onWindowClose() {
    print("onWindowClose");
  }

  @override
  void onWindowFocus() {
    print("onWindowFocus");
  }

  @override
  void onWindowBlur() {
    print("onWindowBlur");
  }

  @override
  void onWindowUnmaximize() {
    print("onWindowUnmaximize");
  }

  // 窗口最下化
  @override
  void onWindowMinimize() {
    print("onWindowMinimize");
  }

  //窗口最大化
  @override
  void onWindowMaximize() {
    print("onWindowMaximize");
  }

  @override
  void onWindowRestore() {
    print("onWindowRestore");
  }

  @override
  void onWindowResize() {
    print("onWindowResize");
  }

  @override
  void onWindowMove() {}

  @override
  void onWindowEnterFullScreen() {
    print("onWindowEnterFullScreen");
  }

  @override
  void onWindowLeaveFullScreen() {
    print("onWindowLeaveFullScreen");
  }
}
