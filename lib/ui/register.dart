import 'package:crypto_wallet/routes/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  final Color primaryColor = Color(0xff18203d);
  final Color secondaryColor = Color(0xff232c51);

  final Color logoGreen = Color(0xff25bcbb);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              "Already a member?",
              style: TextStyle(color: Colors.white),
            ),
            MaterialButton(
              child: Text(
                "Log In",
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
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
                Text(
                  'Sign Up',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 28),
                ),
                SizedBox(
                  height: 35,
                ),
                _buildTextField(userNameController, Icons.account_circle,
                    'Username', false),
                SizedBox(height: 20),
                _buildTextField(emailController, Icons.email, 'Email', false),
                SizedBox(height: 20),
                _buildTextField(
                    passwordController, Icons.lock, 'Password', true),
                SizedBox(height: 20),
                _buildTextField(rePasswordController, Icons.lock,
                    'Re-Enter Password', true),
                SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  minWidth: double.maxFinite,
                  height: 50,
                  onPressed: () async {
                    try {
                      await Firebase.initializeApp();
                      User user = (await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      ))
                          .user;
                      if (user != null) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.authLogin);
                        user.updateDisplayName(userNameController.text);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("displayName", user.displayName);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        userNameController.text = "";
                        emailController.text = "";
                        passwordController.text = "";
                        rePasswordController.text = "";

                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        userNameController.text = "";
                        emailController.text = "";
                        print('Wrong password provided for that user.');
                      }
                      return false;
                    } catch (e) {
                      print(e.toString());
                      return false;
                    }
                  },
                  color: logoGreen,
                  child: Text('Register',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  textColor: Colors.white,
                ),
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
