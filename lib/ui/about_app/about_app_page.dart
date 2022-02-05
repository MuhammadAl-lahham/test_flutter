import 'package:flutter/material.dart';
import 'package:test_flutter/helper/app_colors.dart';
import 'package:test_flutter/helper/font_styles.dart';
import 'package:test_flutter/helper/size_config.dart';

class AboutAppPage extends StatelessWidget {
  static const route = "/about_app_page";

  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("About our app", style: largeWhite),
          backgroundColor: primaryColor1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig().h(8)),
          child: SizedBox.expand(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig().h(20)),
                  child: CircleAvatar(
                      radius: SizeConfig().h(78),
                      backgroundImage: const NetworkImage(
                          'https://cdn.logo.com/hotlink-ok/logo-social.png')),
                ),
                Align(alignment: Alignment.topLeft,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Company name: ", style: mediumBlack),
                          Text("XYZ", style: largeMediumPrimaryColor1),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
