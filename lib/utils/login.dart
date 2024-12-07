import 'package:doctor/utils/shared_preferences_utils.dart';

class LoginUtills {
  static bool isLogin() {
    return SharedPreferencesUtils.get("isLogin") ?? false;
  }
}
