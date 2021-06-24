import 'package:crypto_wallet/routes/route.dart';
import 'package:crypto_wallet/ui/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // Added to ensure the app is properly initilized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Wallet',
      home: Welcome(),
      routes: AppRoutes.define(),
    );
  }
}
