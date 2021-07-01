import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/home/home_controller.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/modules/menu/menu_page.dart';
import 'package:payflow/modules/my_boletos/my_boletos_page.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/navigator.dart';
import 'package:payflow/shared/utils/text_utils.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();
  final controllerLogin = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: [
        MyBoletosPage(key: UniqueKey()),
        ExtractPage(key: UniqueKey()),
        MenuPage(
          key: UniqueKey(),
          user: widget.user,
        )
      ][_homeController.currentPage],
      bottomNavigationBar: buildBottomNavigatorBar(),
    );
  }

  PreferredSize buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(152),
      child: Container(
        height: 152,
        color: AppColors.primary,
        child: Center(
          child: userInfo(),
        ),
      ),
    );
  }

  ListTile userInfo() {
    return ListTile(
        title: Text.rich(
          TextSpan(
            text: "Olá, ",
            style: AppTextStyles.titleRegular,
            children: [
              TextSpan(
                text: treatUsername(widget.user.name),
                style: AppTextStyles.titleBoldBackground,
              ),
            ],
          ),
        ),
        subtitle: Text(
          "Mantenha suas contas em dia",
          style: AppTextStyles.captionShape,
        ),
        trailing: IconButton(
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              size: 25,
            ),
            onPressed: () async {
              await AuthController().deleteUser();
              await controllerLogin.googleLogout(context);
            }),
        leading: GestureDetector(
          onTap: () {
            _homeController.setPage(2);
            setState(() {});
          },
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage(widget.user.photoURL!),
              ),
            ),
          ),
        ));
  }

  SizedBox buildBottomNavigatorBar() {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _homeController.setPage(0);
              });
            },
            icon: Icon(
              Icons.home,
              color: _homeController.currentPage == 0
                  ? AppColors.primary
                  : AppColors.body,
            ),
          ),
          buildAddBoxOutlinedButton(),
          IconButton(
            onPressed: () {
              _homeController.setPage(1);
              setState(() {});
            },
            icon: Icon(
              Icons.description_outlined,
              color: _homeController.currentPage == 1
                  ? AppColors.primary
                  : AppColors.body,
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildAddBoxOutlinedButton() {
    return GestureDetector(
      onTap: () async {
        await push(context, "/barcode_scanner");
        setState(() {});
      },
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Icon(
          Icons.add_box_outlined,
          color: AppColors.background,
        ),
      ),
    );
  }
}
