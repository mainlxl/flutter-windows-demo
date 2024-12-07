import 'package:doctor/app_router.dart';
import 'package:doctor/page/home_page.dart';
import 'package:doctor/utils/login.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _checkLoginStatus());
  }

  void _checkLoginStatus() {
    if (LoginUtills.isLogin()) {
      context.pushReplacement(HomePage());
    } else {
      context.pushReplacement(LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
