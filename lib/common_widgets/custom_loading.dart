import 'package:flutter/material.dart';
import 'package:test_flutter/helper/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: primaryColor1));
  }
}
