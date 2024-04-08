import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bsf/components/already_have_an_account_acheck.dart';
import 'package:bsf/constants.dart';
import 'package:bsf/screens/home_screen/home_screen.dart'; // Correct import path for HomeScreen

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isGoogleSigningIn = false;

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    setState(() {
      _isGoogleSigningIn = true;
    });

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Successfully signed in
        // Navigate to HomeScreen upon successful sign-in
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
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: _isGoogleSigningIn ? null : () => _handleGoogleSignIn(context),
            child: _isGoogleSigningIn
                ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
                : Text("Sign Up with Google"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // background color
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              // Perform sign-up logic here
            },
            child: Text("Sign Up".toUpperCase(), style: TextStyle(color: Colors.black)),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: true,
            press: () {
              // Handle navigation to login screen
            },
          ),
        ],
      ),
    );
  }
}
