import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bsf/components/already_have_an_account_acheck.dart'; // Corrected import path
import '../../../constants.dart';
import '../../home_screen/home_screen.dart';
import '../../signup/signup_screen.dart'; // Make sure this path is correct

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isGoogleSigningIn = false;

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() {
      _isGoogleSigningIn = true;
    });

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Successfully signed in
        // You can now use googleUser.email, googleUser.displayName, etc.
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(), // Navigate to HomeScreen
          ),
        );
      } else {
        // Handle sign-in cancellation
        // For example, you can display a message to the user
        // indicating that sign-in was cancelled.
      }
    } catch (error) {
      // Handle sign-in errors
      // For example, you can display an error message to the user.
      print('Error signing in with Google: $error');
    } finally {
      setState(() {
        _isGoogleSigningIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: _isGoogleSigningIn ? null : () => _handleSignIn(context),
            child: _isGoogleSigningIn
                ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text("Sign in with Google"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // background color
            ),
          ),
          const SizedBox(height: defaultPadding),
          GestureDetector(
            onTap: _isGoogleSigningIn ? null : () => _handleSignIn(context),
            child: Image.asset(
              'assets/icons/google-plus.png', // Path to your Google icon asset
              width: 50, // Adjust size as needed
              height: 50,
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpScreen(), // Navigate to SignUpScreen
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
