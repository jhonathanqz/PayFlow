import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_widget.dart';
import 'package:animated_card/animated_card.dart';

class MyBoletosPage extends StatefulWidget {
  final bool hasNotification;
  const MyBoletosPage({
    Key? key,
    this.hasNotification = true,
  }) : super(key: key);

  @override
  State<MyBoletosPage> createState() => _MyBoletosPageState();
}

class _MyBoletosPageState extends State<MyBoletosPage> {
  final _boletoListController = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Visibility(
            visible: widget.hasNotification,
            child: buildBoletoInfoWidget(),
          ),
          buildTitle(),
          buildLine(),
          BoletoListWidget(
            boletoListController: _boletoListController,
          ),
        ],
      ),
    );
  }

  Stack buildBoletoInfoWidget() {
    return Stack(
      children: [
        Container(
          color: AppColors.primary,
          height: 40,
          width: double.maxFinite,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ValueListenableBuilder<List<BoletoModel>>(
            valueListenable: _boletoListController.boletosNotifier,
            builder: (_, boletos, __) {
              return AnimatedCard(
                direction: AnimatedCardDirection.top,
                child: BoletoInfoWidget(
                  size: boletos.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Meus boletos",
            style: AppTextStyles.titleBoldHeading,
          ),
          ValueListenableBuilder<List<BoletoModel>>(
            valueListenable: _boletoListController.boletosNotifier,
            builder: (_, boletos, __) {
              return Text(
                "${boletos.length} ao total",
                style: AppTextStyles.buttonGray,
              );
            },
          ),
        ],
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
