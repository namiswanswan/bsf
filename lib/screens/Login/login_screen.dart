import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:bsf/components/already_have_an_account_acheck.dart';
import 'package:bsf/constants.dart';
import 'package:bsf/screens/home_screen/home_screen.dart';

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
          // Your form fields and UI elements

          // Example: Text field for username
          TextFormField(
            // Configuration for username text field
          ),

          // Example: Text field for password
          TextFormField(
            // Configuration for password text field
          ),

          // Sign in with Google button
          ElevatedButton(
            onPressed: _isGoogleSigningIn
                ? null
                : () => _handleSignIn(context), // Call _handleSignIn function
            child: _isGoogleSigningIn
                ? CircularProgressIndicator() // Show loading indicator while signing in
                : Text("Sign in with Google"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, // background color
            ),
          ),

          // Other UI elements
          // Placeholder for other UI elements
          // You can add any additional UI elements here

          // Example: Forgot password link
          TextButton(
            onPressed: () {
              // Handle forgot password action
            },
            child: Text("Forgot password?"),
          ),

          // Example: Sign up link
          TextButton(
            onPressed: () {
              // Handle sign up action
            },
            child: Text("Sign up"),
          ),
        ],
      ),
    );
  }
}
