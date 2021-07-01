import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow/shared/auth/auth_controller.dart';
import 'package:payflow/shared/models/user_model.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;

  const InsertBoletoPage({
    Key? key,
    this.barcode,
  }) : super(key: key);

  @override
  State<InsertBoletoPage> createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final _moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );
  final _dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final _barcodeInputTextController = TextEditingController();

  final _insertBoletoController = InsertBoletoController();

  @override
  void initState() {
    if (widget.barcode != "null") {
      _barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  void dispose() {
    _insertBoletoController.dispose();
    super.dispose();
  }

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
      body: buildBody(),
      bottomNavigationBar: buildButtons(),
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: Text(
                "Preencha os dados do boleto",
                style: AppTextStyles.titleBoldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            buildForm(),
          ],
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _insertBoletoController.formKey,
      child: Column(
        children: [
          InputTextWidget(
            icon: Icons.description_outlined,
            label: "Nome do boleto",
            textInputType: TextInputType.name,
            onChanged: (value) {
              _insertBoletoController.onChange(
                name: value,
              );
            },
            validator: _insertBoletoController.validateName,
          ),
          InputTextWidget(
            icon: FontAwesomeIcons.timesCircle,
            label: "Vencimento",
            textInputType: TextInputType.datetime,
            onChanged: (value) {
              _insertBoletoController.onChange(
                dueDate: value,
              );
            },
            controller: _dueDateInputTextController,
            validator: _insertBoletoController.validateDueDate,
          ),
          InputTextWidget(
            icon: FontAwesomeIcons.moneyBillAlt,
            label: "Valor",
            textInputType: TextInputType.number,
            onChanged: (value) {
              _insertBoletoController.onChange(
                value: _moneyInputTextController.numberValue,
              );
            },
            controller: _moneyInputTextController,
            validator: (_) => _insertBoletoController.validateValue(
              _moneyInputTextController.numberValue,
            ),
          ),
          InputTextWidget(
            icon: FontAwesomeIcons.barcode,
            label: "Código",
            textInputType: TextInputType.number,
            onChanged: (value) {
              _insertBoletoController.onChange(
                barcode: value,
              );
            },
            controller: _barcodeInputTextController,
            validator: _insertBoletoController.validateCode,
          ),
        ],
      ),
    );
  }

  StreamBuilder<bool> buildButtons() {
    return StreamBuilder<bool>(
      stream: _insertBoletoController.output,
      builder: (context, snapshot) {
        return SetLabelButtons(
          primaryLabel: "Cancelar",
          primaryOnPressed: () =>
              Navigator.popUntil(context, ModalRoute.withName("/home")),
          enableSecondaryColor: true,
          showProgress: _insertBoletoController.isProcessing,
          secondaryLabel: "Cadastrar",
          secondaryOnPressed: () async {
            if (_barcodeInputTextController.text.isNotEmpty &&
                _moneyInputTextController.text.isNotEmpty &&
                _dueDateInputTextController.text.isNotEmpty) {
              await _insertBoletoController.registerBoleto();
              UserModel user = await AuthController().getCurrentUser(context);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false,
                  arguments: user);
              //Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Verifique os campos em branco.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(
                    seconds: 3,
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
