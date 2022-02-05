import 'package:flutter/material.dart';
import 'package:test_flutter/helper/size_config.dart';

class SeparaterWidget extends StatelessWidget {
  const SeparaterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: SizeConfig().h(10), width: SizeConfig().w(5));
  }
}
