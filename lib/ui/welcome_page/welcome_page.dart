import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_flutter/common_widgets/custom_textfield_widget.dart';
import 'package:test_flutter/helper/size_config.dart';
import 'package:test_flutter/utils/local_data.dart';

class WelcomePage extends StatelessWidget {
  static const route = "/WelcomePage";

  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    final usernameController = TextEditingController();

    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(SizeConfig().h(8.0)),
            child: CustomTextFieldWidget(
              controller: usernameController,
              aboveTitle: "Select your username:",
              hintText: "Your username",
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (stringValue) async {
                await LocalData().editUserName(stringValue);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Welcome $stringValue"),
                    duration: const Duration(seconds: 5)));

                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    ));
  }
}
