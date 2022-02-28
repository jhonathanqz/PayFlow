import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';
import 'package:payflow/shared/widgets/error_message/error_message_widget.dart';

class ExtractPage extends StatefulWidget {
  const ExtractPage({Key? key}) : super(key: key);

  @override
  State<ExtractPage> createState() => _ExtractPageState();
}

class _ExtractPageState extends State<ExtractPage> {
  final _boletoListController = BoletoListController(onlyPayed: true);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitle(),
          buildLine(),
          buildListView(),
        ],
      ),
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
            "Meus extratos",
            style: AppTextStyles.titleBoldHeading,
          ),
          ValueListenableBuilder<List<BoletoModel>>(
            valueListenable: _boletoListController.boletosNotifier,
            builder: (_, boletos, __) {
              int counter = 0;

              boletos.map((boleto) {
                if (boleto.isPaid) {
                  counter++;
                }
              });
              final totalizer = boletos.fold<double>(
                  0, (sum, next) => sum + next.value!.toDouble());
              return Column(
                children: [
                  Text(
                    "${boletos.length <= 1 ? "${boletos.length} pago" : "${boletos.length} pagos"}",
                    style: AppTextStyles.buttonGray,
                  ),
                  Text(
                    'R\$ ${totalizer.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: AppTextStyles.buttonGray,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Padding buildLine() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Divider(
        thickness: 1,
        height: 1,
        color: AppColors.stroke,
      ),
    );
  }

  ValueListenableBuilder<List<BoletoModel>> buildListView() {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: _boletoListController.boletosNotifier,
      builder: (_, boletos, __) {
        List<BoletoModel> list = <BoletoModel>[];

        for (var boleto in boletos) {
          if (boleto.isPaid) {
            list.add(boleto);
          }
        }

        return Visibility(
          visible: list.isNotEmpty,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return BoletoTileWidget(
                boletoModel: list[index],
              );
            },
          ),
          replacement: const ErrorMessageWidget(
            text: "Nenhum boleto foi pago",
            icon: FontAwesomeIcons.sadCry,
          ),
        );
      },
    );
  }
}
