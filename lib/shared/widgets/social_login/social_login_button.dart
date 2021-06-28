import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class SocialLoginButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final bool showProgress;

  const SocialLoginButton({
    Key? key,
    required this.onTap,
    this.showProgress = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.primary,
      child: Ink(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.shape,
          borderRadius: BorderRadius.circular(5),
          border: const Border.fromBorderSide(
            BorderSide(color: AppColors.stroke),
          ),
        ),
        child: showProgress
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : buildGoogleButton(),
      ),
    );
  }

  Row buildGoogleButton() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 12,
              ),
              Image.asset(
                AppImages.google,
              ),
              const SizedBox(
                width: 12,
              ),
              Container(
                height: 56,
                width: 1,
                color: AppColors.stroke,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Entrar com Google",
                style: AppTextStyles.buttonGray,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
