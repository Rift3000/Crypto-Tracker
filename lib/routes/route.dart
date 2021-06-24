import 'package:crypto_wallet/ui/login.dart';
import 'package:crypto_wallet/ui/register.dart';
import 'package:crypto_wallet/ui/switch.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String switcher = '/home';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => LoginScreen(),
      authRegister: (context) => RegisterScreen(),
      switcher: (context) => Switcheroo(),
    };
  }
}
