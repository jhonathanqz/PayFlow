import 'package:flutter/material.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_controller.dart';
import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/utils/navigator.dart';
import 'package:payflow/shared/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({Key? key}) : super(key: key);

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final _barcodeScannerController = BarcodeScannerController();

  @override
  void initState() {
    _barcodeScannerController.getAvailableCameras();
    _barcodeScannerController.statusNotifier.addListener(() {
      if (_barcodeScannerController.status.hasBarcode) {
        push(
          context,
          "/insert_boleto",
          arguments: _barcodeScannerController.status.barcode,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _barcodeScannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          buildPreview(),
          RotatedBox(
            quarterTurns: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: buildAppBar(),
              body: buildBody(),
              bottomNavigationBar: SetLabelButtons(
                primaryLabel: "Inserir código do boleto",
                primaryOnPressed: () => popAndPush(context, "/insert_boleto"),
                secondaryLabel: "Adicionar da galeria",
                secondaryOnPressed:
                    _barcodeScannerController.scanWithImagePicker,
              ),
            ),
          ),
          buildBottomSheetWidget(),
        ],
      ),
    );
  }

  ValueListenableBuilder<BarcodeScannerStatus> buildPreview() {
    return ValueListenableBuilder<BarcodeScannerStatus>(
      valueListenable: _barcodeScannerController.statusNotifier,
      builder: (_, status, __) {
        if (status.showCamera) {
          return Container(
            color: Colors.blue,
            child: _barcodeScannerController.cameraController!.buildPreview(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      title: Text(
        "Escaneie o código de barras do boleto",
        style: AppTextStyles.buttonBackground,
      ),
      leading: const BackButton(color: AppColors.background),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        Expanded(
          child: Container(color: Colors.black),
        ),
        Expanded(
          flex: 2,
          child: Container(color: Colors.transparent),
        ),
        Expanded(
          child: Container(color: Colors.black),
        )
      ],
    );
  }

  ValueListenableBuilder<BarcodeScannerStatus> buildBottomSheetWidget() {
    return ValueListenableBuilder<BarcodeScannerStatus>(
      valueListenable: _barcodeScannerController.statusNotifier,
      builder: (_, status, __) {
        if (status.hasError) {
          return Align(
            alignment: Alignment.bottomLeft,
            child: BottomSheetWidget(
              title: "Não foi possível identificar um código de barras.",
              subtitle:
                  "Tente escanear novamente ou digite o código do seu boleto.",
              primaryLabel: "Escanear novamente",
              primaryOnPressed: () {
                _barcodeScannerController.scanWithCamera();
              },
              secondaryLabel: "Digitar código",
              secondaryOnPressed: () => popAndPush(context, "/insert_boleto"),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
