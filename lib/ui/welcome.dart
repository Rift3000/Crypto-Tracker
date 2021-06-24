import 'package:crypto_wallet/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final Color primaryColor = Color(0xff18203d);
  final Color buttonGreen = Color(0xff25bcbb);
  final Color otherGreen = Color(0xff2D9DD1);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'images/welcome.svg',
              semanticsLabel: 'Welcome Image',
              height: mq.height / 3,
              width: mq.width / 3,
            ),
            SizedBox(
              height: 50,
            ),
            //Texts and Styling of them
            Text('Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: mq.width / 14)),
            SizedBox(height: 40),
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              color: buttonGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ],
              ),
              textColor: Colors.white,
            ),
            SizedBox(height: 20),
            MaterialButton(
              elevation: 0,
              height: 50.0,
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              color: otherGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Register',
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ],
              ),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
