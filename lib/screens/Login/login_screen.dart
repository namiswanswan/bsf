import 'package:firebase_auth/firebase_auth.dart';
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

//   Future<void> _handleSignIn(BuildContext context) async {
//     // setState(() {
//     //   _isGoogleSigningIn = true;
//     // });
//
//     final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(
//         GoogleAuthProvider.credential(
//           idToken: googleUser.idToken,
//           accessToken: googleUser.accessToken,
//         ),
//       );
//
// // Setting the current user after successful authentication
//       FirebaseAuth.instance.currentUser = userCredential.user;      print(googleUser);
//       if (googleUser != null) {
//         // Successfully signed in
//         // Navigate to HomeScreen upon successful sign-in
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeScreen(), // Navigate to HomeScreen
//           ),
//         );
//       } else {
//         // Handle sign-in cancellation
//         // For example, you can display a message to the user
//         // indicating that sign-in was cancelled.
//       }
//     } catch (error) {
//       // Handle sign-in errors
//       // For example, you can display an error message to the user.
//       print('Error signing in with Google: $error');
//     } finally {
//       setState(() {
//         _isGoogleSigningIn = false;
//       });
//     }
//   }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? user = authResult.user;

        return user;
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Image.asset('assets/icons/login.png'),
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
                onPressed:_signInWithGoogle,
                // _isGoogleSigningIn
                //     ? null
                //     :
                //     () =>
                //         _signInWithGoogle(), // Call _handleSignIn function
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
      ),
    );
    // return Form(
    //   child: Column(
    //     children: [
    //       // Your form fields and UI elements
    //
    //       // Example: Text field for username
    //       TextFormField(
    //         // Configuration for username text field
    //       ),
    //
    //       // Example: Text field for password
    //       TextFormField(
    //         // Configuration for password text field
    //       ),
    //
    //       // Sign in with Google button
    //       ElevatedButton(
    //         onPressed: _isGoogleSigningIn
    //             ? null
    //             : () => _handleSignIn(context), // Call _handleSignIn function
    //         child: _isGoogleSigningIn
    //             ? CircularProgressIndicator() // Show loading indicator while signing in
    //             : Text("Sign in with Google"),
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: Colors.black, // background color
    //         ),
    //       ),
    //
    //       // Other UI elements
    //       // Placeholder for other UI elements
    //       // You can add any additional UI elements here
    //
    //       // Example: Forgot password link
    //       TextButton(
    //         onPressed: () {
    //           // Handle forgot password action
    //         },
    //         child: Text("Forgot password?"),
    //       ),
    //
    //       // Example: Sign up link
    //       TextButton(
    //         onPressed: () {
    //           // Handle sign up action
    //         },
    //         child: Text("Sign up"),
    //       ),
    //     ],
    //   ),
    // );
  }
}
