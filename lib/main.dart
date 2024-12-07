import 'package:doctor/app_router.dart';
import 'package:doctor/utils/config.dart';
import 'package:doctor/utils/shared_preferences_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow(
      const WindowOptions(
        size: Size(800, 600),
        backgroundColor: Colors.transparent,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.normal,
        fullScreen: !isDebug,
      ), () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await SharedPreferencesUtils.init();

  await EasyLocalization.ensureInitialized();

  EasyLocalization.logger.enableBuildModes = []; //去除多语言日志
  runApp(
    OKToast(
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('zh', '')],
        path: 'langs',
        child: _MyApp(),
      ),
    ),
  );
}

class _MyApp extends StatelessWidget {
  const _MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
    );
  }
}
