import 'package:crypto_wallet/routes/route.dart';
import 'package:crypto_wallet/ui/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Color primaryColor = Color(0xff18203d);

  final Color secondaryColor = Color(0xff232c51);

  final Color buttonGreen = Color(0xff25bcbb);

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Not a member?",
              style: TextStyle(color: Colors.white),
            ),
            MaterialButton(
              child: Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()));
              },
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        backgroundColor: primaryColor,
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'images/secure_login.svg',
                  semanticsLabel: 'Log In Image',
                  height: mq.height / 5,
                  width: mq.width / 5,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Log In',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(
                  height: 30,
                ),
                _buildTextField(
                    emailController, Icons.account_circle, 'Email', false),
                SizedBox(height: 20),
                _buildTextField(
                    passwordController, Icons.lock, 'Password', true),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    try {
                      await Firebase.initializeApp();
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      if (userCredential != null) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.switcher);

                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                            "displayName", userCredential.user.displayName);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        emailController.text = "";
                        passwordController.text = "";
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        emailController.text = "";
                        passwordController.text = "";
                        print('Wrong password provided for that user.');
                      }
                    }
                  },
                  color: buttonGreen,
                  child: Text('Login',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  textColor: Colors.white,
                ),
                SizedBox(height: 20),
                bottom,
              ],
            ),
          ),
        ));
  }

  _buildTextField(TextEditingController controller, IconData icon,
      String labelText, bool obscure) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
