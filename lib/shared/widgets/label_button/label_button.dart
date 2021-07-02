import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? style;
  final bool showProgress;
  final Color backgroundColor;

  const LabelButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.showProgress = false,
    this.style,
    this.backgroundColor = AppColors.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 80,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
        ),
        child: showProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                label,
                style: style ?? AppTextStyles.buttonHeading,
              ),
      ),
    );
  }
}
