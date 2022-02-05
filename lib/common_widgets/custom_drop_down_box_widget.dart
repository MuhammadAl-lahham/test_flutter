import 'package:flutter/material.dart';
import 'package:test_flutter/helper/size_config.dart';

class CustomDropDownWidget extends StatefulWidget {
  final double? itemHeight;
  final List<String> items;

  CustomDropDownWidget({Key? key, this.itemHeight, required this.items})
      : assert(items.isNotEmpty),
        super(key: key);

  @override
  State<CustomDropDownWidget> createState() => CustomDropDownWidgetState();
}

class CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  late String currentValue = widget.items[0];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        isExpanded: true,
        value: currentValue,
        itemHeight: widget.itemHeight ?? SizeConfig().h(50),
        alignment: Alignment.bottomCenter,
        menuMaxHeight: SizeConfig().h(150),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: SafeArea(child: Text(value)),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            currentValue=newValue!;
          });
        });
  }
}
