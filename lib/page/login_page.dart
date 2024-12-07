import 'package:doctor/app_router.dart';
import 'package:doctor/page/home_page.dart';
import 'package:doctor/utils/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _isCountdownActive = false;
  int _countdown = 60;

  void _startCountdown() {
    setState(() {
      _isCountdownActive = true;
      _countdown = 60;
    });

    Future.delayed(Duration(seconds: 1), _countdownTimer);
  }

  void _countdownTimer() {
    if (_countdown > 0) {
      setState(() {
        _countdown--;
      });
      Future.delayed(Duration(seconds: 1), _countdownTimer);
    } else {
      setState(() {
        _isCountdownActive = false;
      });
    }
  }

  void _getVerificationCode() {
    if (_phoneController.text.isEmpty) {
      showToast("请输入手机号".tr());
      return;
    }

    //TODO 这里可以添加获取验证码的逻辑，比如调用 API
    showToast("验证码已发送".tr());

    _startCountdown();
  }

  void _login() {
    if (_phoneController.text.isEmpty || _codeController.text.isEmpty) {
      showToast("请填入手机号和验证码".tr());
      return;
    }
    showToast("登录成功".tr());
    //TODO
    context.pushReplacement(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "登录".tr(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              controller: _phoneController,
              label: "手机号".tr(),
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
            ),
            const SizedBox(height: 20),
            _buildCodeInputRow(),
            const SizedBox(height: 20),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildCodeInputRow() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: _codeController,
            label: "验证码".tr(),
            keyboardType: TextInputType.number,
            icon: Icons.lock,
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _isCountdownActive ? null : _getVerificationCode,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            _isCountdownActive
                ? "{seconds}秒后重发".tr(namedArgs: {"seconds": "$_countdown"})
                : "获取验证码".tr(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        "登录".tr(),
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}
