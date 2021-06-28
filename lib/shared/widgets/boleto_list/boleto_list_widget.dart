import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow/shared/widgets/boleto_tile/boleto_tile_widget.dart';
import 'package:payflow/shared/widgets/error_message/error_message_widget.dart';

class BoletoListWidget extends StatefulWidget {
  final BoletoListController boletoListController;

  const BoletoListWidget({
    Key? key,
    required this.boletoListController,
  }) : super(key: key);

  @override
  _BoletoListWidgetState createState() => _BoletoListWidgetState();
}

class _BoletoListWidgetState extends State<BoletoListWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.boletoListController.boletosNotifier,
      builder: (_, boletos, __) {
        List<BoletoModel> list = <BoletoModel>[];

        for (var boleto in boletos) {
          if (!boleto.isPaid) {
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
            text: "Nenhum boleto pendente",
            icon: FontAwesomeIcons.smile,
          ),
        );
      },
    );
  }
}
