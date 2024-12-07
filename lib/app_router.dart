import 'package:doctor/page/dialog_page.dart';
import 'package:doctor/page/second_page.dart';
import 'package:doctor/page/splash_screen_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Future<T?> pushPage<T extends Object?>(
    BuildContext context,
    String pageName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(pageName, arguments: arguments);
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      BuildContext context, Widget pageWidget,
      {TO? result}) {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => pageWidget),
        result: result);
  }

  static void popPage<T extends Object?>(BuildContext context, [T? result]) {
    return Navigator.pop(context, result);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'second':
        return MaterialPageRoute(builder: (_) => const SecondPage());
      case 'dialog':
        return MaterialPageRoute(builder: (_) => const SmartDialogPage());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreenPage());
    }
  }
}

extension AppRouterStateExtensions on State {
  void popPage<T extends Object?>([T? result]) {
    return Navigator.pop(this.context, result);
  }
}

extension AppRouterBuildContextExtensions on BuildContext {
  void popPage<T extends Object?>([T? result]) {
    return AppRouter.popPage(this, result);
  }

  Future<T?> pushPage<T extends Object?>(
    String pageName, {
    Object? arguments,
  }) {
    return AppRouter.pushPage<T>(this, pageName, arguments: arguments);
  }

  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
      Widget pageWidget,
      {TO? result}) {
    return AppRouter.pushReplacement(this, pageWidget, result: result);
  }
}
