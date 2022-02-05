import 'package:flutter/material.dart';
import 'package:test_flutter/ui/about_app/about_app_page.dart';
import 'package:test_flutter/ui/home_page.dart';
import 'package:test_flutter/ui/splash_screen/splash_screen.dart';
import 'package:test_flutter/ui/welcome_page/welcome_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.route:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case WelcomePage.route:
        return MaterialPageRoute(builder: (_) => const WelcomePage());

      case HomePage.route:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AboutAppPage.route:
        return MaterialPageRoute(builder: (_) => const AboutAppPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
