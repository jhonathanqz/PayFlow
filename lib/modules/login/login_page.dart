import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50.0)),
              ),
            ),
            Positioned(
                top: 130,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.person,
                  width: 208,
                  height: 300,
                )),
            Positioned(
                top: 230,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppImages.degrade,
                  width: 208,
                  height: 300,
                )),
            Positioned(
              bottom: size.height * 0.2,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logomini),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 35, left: 70, right: 70, bottom: 10),
                    child: Text(
                      "Organize seus boletos em um só lugar",
                      textAlign: TextAlign.center,
                      style: TextStyles.titleHome,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 45),
                    child: SocialLoginButton(
                      onTap: () {
                        controller.googleSignIn(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 750,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: 15),
                height: 50,
                child: Image.asset(
                  AppImages.payflow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
