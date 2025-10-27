import 'package:flutter/material.dart';

class ProjectButtonWidget extends StatelessWidget {
  const ProjectButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.bgColor,
  });
  final String text;
  final void Function()? onPressed;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: SizedBox(),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 0.2),
        ),
      ),
      onPressed: onPressed,
      label: Text(text),
    );
  }
}
