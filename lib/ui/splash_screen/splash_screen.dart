import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/helper/size_config.dart';
import 'package:test_flutter/ui/welcome_page/welcome_page.dart';
import 'package:test_flutter/utils/local_data.dart';

class SplashScreen extends StatefulWidget {
  static const route = "/splash_screen";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ImageProvider logoImage;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    SizeConfig().init(context);
    final h230 = SizeConfig().h(230);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(clipBehavior: Clip.antiAliasWithSaveLayer, children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig().h(367)),
              height: h230,
              decoration: BoxDecoration(
                  image: DecorationImage(image: logoImage, fit: BoxFit.cover)),
            ),
          )
        ]));
  }

  @override
  void initState() {
    super.initState();
    logoImage = const AssetImage('assets/png/logo_social.png');
    WidgetsBinding.instance!.addPostFrameCallback(
        (_) => Future.delayed(const Duration(seconds: 3), () {
              asyncMethod();
            }));
  }

  void asyncMethod() async {
    var username = await LocalData().getCurrentUserName();
    if (username != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Welcome $username"),
          duration: const Duration(seconds: 5)));
      Navigator.pop(context);
    } else {
      Navigator.pushReplacementNamed(context, WelcomePage.route);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(logoImage, context);
    SizeConfig().init(context);
  }
}
