import 'package:flutter/material.dart';
import 'package:test_flutter/helper/const_sizes.dart';
import 'package:test_flutter/helper/const_styles.dart';
import 'package:test_flutter/helper/font_styles.dart';
import 'package:test_flutter/helper/size_config.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String aboveTitle;
  final bool lightTheme;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputType? textInputType;


  const CustomTextFieldWidget(
      {Key? key,
      this.hintText,
      required this.controller,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted,
      this.textInputType,
      required this.aboveTitle, this.lightTheme=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    ValueNotifier<bool?> showError = ValueNotifier<bool?>(null);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(aboveTitle, style: lightTheme?largeMediumPrimaryColor2:mediumWhite),
      Padding(
    padding:
        EdgeInsets.only(top: SizeConfig().h(6), bottom: SizeConfig().h(14)),
    child: ValueListenableBuilder<bool?>(
        valueListenable: showError,
        builder: (BuildContext context, value, Widget? child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: SizeConfig().h(47),
                    decoration: BoxDecoration(
                        borderRadius: radiusAll14,
                        color: Colors.white),
                    child: TextFormField(
                        controller: controller,
                        cursorColor: Colors.black,
                        focusNode: focusNode,
                        textInputAction: textInputAction,
                        keyboardType: textInputType,
                        style: largeMediumPrimaryColor2,
                        maxLines: 1,
                        onFieldSubmitted: onFieldSubmitted,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: radiusAll14,
                            ),
                            errorStyle: const TextStyle(color: Colors.red),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: showError.value == null
                                        ? Colors.amber
                                        : showError.value == true
                                            ? Colors.red
                                            : Colors.green,
                                    width: width1),
                                borderRadius: radiusAll14),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: showError.value == null
                                        ? const Color(0xffd8e0e5)
                                        : showError.value == true
                                            ? Colors.red
                                            : Colors.green,
                                    width: width1),
                                borderRadius: radiusAll14),
                            hintStyle: smallCustomGreyColor4,
                            contentPadding: EdgeInsets.fromLTRB(
                                SizeConfig().w(20),
                                0,
                                SizeConfig().w(20),
                                SizeConfig().h(16)),
                            hintText: hintText),
                        onChanged: (stringValue) {
                          showError.value = stringValue=="";
                        })),
                if (value != null && value)
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig().w(10)),
                      child: Text("you have to fill this field!",
                          style: errorStyle))
              ]);
        }),
      ),
    ]);
  }
}
