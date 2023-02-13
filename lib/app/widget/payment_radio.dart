import 'package:flutter/material.dart';
import 'package:siopa/app/widget/button_container.dart';

class RadiolistTile extends StatelessWidget {
  const RadiolistTile({
    super.key,
    required this.title,
    required this.widget,
    required this.groupValue,
    required this.value,
    required this.onchanged,
  });
  final String title;
  final Widget widget;
  final int groupValue;
  final int value;
  final Function onchanged;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onchanged(value);
        }
      },
      child: ListTile(
        title: TextTitle(
            title: title, ls: 0, fontwght: FontWeight.w500, fontsz: 18),
        subtitle: widget,
        leading: Radio<int>(
          groupValue: groupValue,
          value: value,
          onChanged: (int? newValue) {
            onchanged(newValue);
          },
        ),
      ),
    );
  }
}
