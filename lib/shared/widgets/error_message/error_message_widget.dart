import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const ErrorMessageWidget({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 15),
          Text(
            text,
            style: AppTextStyles.buttonGray,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
