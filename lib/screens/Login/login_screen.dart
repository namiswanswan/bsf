import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bsf/screens/home_screen/home_screen.dart';
import 'package:bsf/screens/Login/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isGoogleSigningIn = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isGoogleSigningIn = true;
    });

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        if (user != null && user.providerData.any((info) => info.providerId == 'google.com')) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      // Handle sign-in errors here
    } finally {
      setState(() {
        _isGoogleSigningIn = false;
      });
    }
  }

  void _signUpWithEmail(BuildContext context) {
    // Handle sign up with email action
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logofood.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            primary: false, // Set primary to false
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 450), // Increase space before buttons

                SizedBox(
                  width: 250, // Adjust the width to your preference
                  height: 50, // Adjust the height to your preference
                  child: ElevatedButton.icon(
                    onPressed: _signInWithGoogle,
                    icon: Image.asset(
                      'assets/icons/google.png', // Provide the path to the Google logo asset
                      height: 24, // Adjust the height of the logo as needed
                      width: 24, // Adjust the width of the logo as needed
                    ),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign in with Google",
                          style: TextStyle(fontSize: 16), // Adjust the font size
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // background color
                      elevation: 20, // Add elevation for shadow effect
                    ),
                  ),
                ),

                SizedBox(height:20), // Increase space between buttons

                SizedBox(
                  width: 250, // Adjust the width to your preference
                  height: 50, // Adjust the height to your preference
                  child: ElevatedButton.icon(
                    onPressed: _signUpWithEmail,
                    icon: Icon(Icons.mail_outline), // Add email icon
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sign up with Email",
                          style: TextStyle(fontSize: 16), // Adjust the font size
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // background color
                      elevation: 20, // Add elevation for shadow effect
                    ),
                  ),
                ),

                SizedBox(height: 10), // Increase space after buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}