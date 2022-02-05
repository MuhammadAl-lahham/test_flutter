import 'package:flutter/material.dart';

import 'helper/app_colors.dart';
import 'ui/splash_screen/splash_screen.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Test ML',
        theme:
        ThemeData(primaryColor: primaryColor1,fontFamily: "Poppins"),
        initialRoute: SplashScreen.route,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false
    );
  }
}