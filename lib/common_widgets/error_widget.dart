
import 'package:flutter/material.dart';
import 'package:test_flutter/helper/size_config.dart';
import 'package:test_flutter/model/error_model.dart';

class CustomErrorWidget extends StatelessWidget {
  final ErrorModel errorModel;
  final bool showPngPic;
  final TextStyle? textStyle;

  const CustomErrorWidget(
      {Key? key,
      required this.errorModel,
      this.textStyle,
      this.showPngPic = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      if (showPngPic)
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/png/" + getImagePath()))),
          margin: EdgeInsets.only(bottom: SizeConfig().h(15)),
        ),
      Text(errorModel.errorValue, style: textStyle)
    ]));
  }

  String getImagePath() {
    switch (errorModel.errorType) {
      case ErrorType.other:
        return "something_error.png";
      case ErrorType.noItemsError:
        return "no_items_found.png";
      default:
        return "something_error.png";
    }
  }
}
