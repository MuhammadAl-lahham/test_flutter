import 'package:flutter/material.dart';
import 'package:test_flutter/helper/size_config.dart';
import 'package:test_flutter/model/error_model.dart';

class RetryConnectErrorWidget extends StatelessWidget {
  final ErrorModel errorModel;
  final double maxHeight;
  final TextStyle? textStyle;

  const RetryConnectErrorWidget(
      {Key? key,
      required this.errorModel,
      required this.maxHeight,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = SizeConfig().h(200);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: maxHeight),
        child: Center(
            child: Column(
          children: [
            Container(
              height: size,
              width: size*2,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.fill,
                      image: AssetImage("assets/png/" + getImagePath()))),
              margin: EdgeInsets.only(bottom: SizeConfig().h(15)),
            ),
            Text(errorModel.errorValue, style: textStyle),
          ],
        )),
      ),
    );
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
