import 'package:flutter/material.dart';
import 'package:bsf/core/theme/app_theme.dart';
import 'package:bsf/core/utils/size_config.dart';
import 'package:bsf/screens/splash_screen.dart';
import 'package:bsf/screens/home_screen/home_screen.dart';
import 'package:bsf/screens/vendor_screen/vendor_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:bsf/core/utils/navigation.dart'; // Import the Navigation class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeConfiguration(
      builder: (_) => MaterialApp(
        title: 'Foodie',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/vendor_screen': (context) => const VendorScreen(),
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/vendor') {
            // Push the splash screen
            Navigation.pushReplacement(
              context,
              screen: const SplashScreen(),
            );
            // Return null to prevent the default navigation
            return null;
          }
          return null;
        },
      ),
    );
  }
}
