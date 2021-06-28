import 'package:flutter/material.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/field/field_widget.dart';

class ProfilePage extends StatelessWidget {
  final UserModel user;
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(
          color: AppColors.input,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            buildTitle(),
            buildLine(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildImage(),
                  const SizedBox(height: 10),
                  buildField(
                    title: "Nome",
                    content: user.name,
                  ),
                  buildField(
                    title: "E-mail",
                    content: user.email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(user.photoURL!),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Column buildField({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Text(
            title,
            style: AppTextStyles.titleListTile,
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 16,
          ),
          child: FieldWidget(text: content),
        ),
      ],
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
      ),
      child: Text(
        "Perfil",
        style: AppTextStyles.titleHome,
      ),
    );
  }

  Padding buildLine() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 24,
      ),
      child: Divider(
        thickness: 1,
        height: 1,
        color: AppColors.stroke,
      ),
    );
  }
}
