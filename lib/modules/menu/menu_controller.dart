import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/menu/items_page.dart';
import 'package:payflow/modules/my_boletos/my_boletos_page.dart';
import 'package:payflow/modules/profile/profile_page.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/navigator.dart';
import 'package:payflow/shared/widgets/alert/app_alert.dart';
import 'package:payflow/shared/widgets/menu/menu.dart';
import 'package:payflow/shared/widgets/menu/menu_item.dart';
import 'package:payflow/shared/widgets/menu/title_and_backbutton.dart';

class MenuController {
  BuildContext context;
  UserModel user;

  MenuController({
    required this.context,
    required this.user,
  });

  Menu get loadMenu => _mainMenu;

  Menu get _mainMenu {
    List<Widget> itens = [
      MenuItem(
        icon: FontAwesomeIcons.userCircle,
        title: "Perfil",
        nextPageFunction: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemsPage(body: _profileMenu);
            },
          ));
        },
      ),
      MenuItem(
        icon: FontAwesomeIcons.fileAlt,
        title: "Boletos",
        nextPageFunction: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ItemsPage(body: _boletosMenu);
            },
          ));
        },
      ),
      MenuItem(
        icon: FontAwesomeIcons.signOutAlt,
        title: "Sair",
        nextPageFunction: () {
          AppAlert.dialog(
            context: context,
            title: "Sair do PayFlow?",
            message: "Deseja mesmo sair do aplicativo?",
            firstButtonTitle: "Não",
            secondButtonTitle: "Sim",
            function: () async {
              await AuthController().logout();
              push(
                context,
                "/login",
                replace: true,
              );
            },
          );
        },
      ),
    ];

    return Menu(
      menuItems: itens,
    );
  }

  Menu get _profileMenu {
    List<Widget> itens = [
      TitleAndBackButton(
        child: Text(
          "Perfil",
          style: AppTextStyles.titleMenu,
        ),
      ),
      MenuItem(
        title: "Visualizar Perfil",
        nextPageFunction: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProfilePage(user: user);
            },
          ));
        },
        icon: FontAwesomeIcons.user,
      ),
    ];

    return Menu(menuItems: itens);
  }

  Menu get _boletosMenu {
    List<Widget> itens = [
      TitleAndBackButton(
        child: Text(
          "Boletos",
          style: AppTextStyles.titleMenu,
        ),
      ),
      MenuItem(
        icon: FontAwesomeIcons.barcode,
        title: "Scannear Barcode",
        nextPageFunction: () => push(context, "/barcode_scanner"),
      ),
      MenuItem(
        icon: FontAwesomeIcons.fileMedical,
        title: "Cadastrar Boleto",
        nextPageFunction: () => push(context, "/insert_boleto"),
      ),
      MenuItem(
        icon: FontAwesomeIcons.fileImport,
        title: "Meus Boletos",
        nextPageFunction: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.background,
                  elevation: 0,
                  leading: const BackButton(
                    color: AppColors.input,
                  ),
                ),
                body: const MyBoletosPage(
                  hasNotification: false,
                ),
              );
            },
          ));
        },
      ),
      MenuItem(
        icon: FontAwesomeIcons.fileContract,
        title: "Meus Extratos",
        nextPageFunction: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.background,
                  elevation: 0,
                  leading: const BackButton(
                    color: AppColors.input,
                  ),
                ),
                body: const ExtractPage(),
              );
            },
          ));
        },
      ),
    ];

    return Menu(
      menuItems: itens,
    );
  }
}
