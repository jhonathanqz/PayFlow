import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:payflow/shared/utils/boleto/boleto_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final _formKey = GlobalKey<FormState>();
  BoletoModel model = BoletoModel();

  List<bool> _campoVisivel = [false, false, false, false];
  bool isVisivel(int index) => _campoVisivel[index];
  set campoVisivel(int index) => _campoVisivel[index] = true;
  void allCampoVisivel() =>
      _campoVisivel = _campoVisivel.map((e) => e = true).toList();
  String? _codigoBoleto;
  String get codigoBoleto => _codigoBoleto!;
  set codigoBoleto(String v) =>
      _codigoBoleto = v.replaceAll(".", "").replaceAll("-", "");

  var codigoDividido = List<String>.generate(5, (i) => "");

  bool _isProcessing = false;

  final _streamController = StreamController<bool>();

  Sink<bool> get input => _streamController.sink;
  Stream<bool> get output => _streamController.stream;

  bool get isProcessing => _isProcessing;

  GlobalKey<FormState> get formKey => _formKey;

  String? validateName(String? value) {
    return value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  }

  String? validateValor(double? value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;

  String? validateDueDate(String? value) {
    return value?.isEmpty ?? true
        ? "A data de vencimento não pode ser vazio"
        : null;
  }

  String? validateValue(double value) {
    return value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  }

  String? validateCode(String? value) {
    return value?.isEmpty ?? true
        ? "O código do boleto não pode ser vazio"
        : null;
  }

  String? validaCampo1(String? value) {
    if (value!.isEmpty)
      return "O código não pode ser vazio";
    else if (value.length < 11)
      return "O código está incompleto";
    else
      return null;
  }

  String? validaCampo2e3(String? value) {
    if (value!.isEmpty)
      return "O código não pode ser vazio";
    else if (value.length < 12)
      return "O código está incompleto";
    else
      return null;
  }

  String? validaCampo4(String? value) =>
      value!.isEmpty ? "O código não pode ser vazio" : null;

  String? validaCampo5(String? value) {
    if (value!.isEmpty)
      return "O código não pode ser vazio";
    else if (value.length < 14)
      return "O código está incompleto";
    else
      return null;
  }

  String getDataVencimento() {
    String codigo =
        codigoBoleto.length == 47 ? divideCodigo()[4] : divideCodigo()[1];
    String dias = codigo.substring(0, 4);
    DateTime vencimento = DateUtils.addDaysToDate(
        DateTime.parse(BoletoUtils.DATA_BASE), int.parse(dias));

    return DateFormat(BoletoUtils.FORMAT_DATA).format(vencimento);
  }

  String getValor() {
    String codigo =
        codigoBoleto.length == 47 ? divideCodigo()[4] : divideCodigo()[1];
    String valor = codigo.substring(4);
    return NumberFormat(BoletoUtils.FORMAT_VALOR).format(int.parse(valor));
  }

  void msgErroBoleto(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          elevation: 4,
          content: Text("O código do boleto é inválido"),
        ),
      );
  }

  List<String> divideCodigo() {
    var codigo = List<String>.generate(5, (i) => "");

    if (codigoBoleto.length == 47) {
      codigo[0] = codigoBoleto.substring(0, 10);
      codigo[1] = codigoBoleto.substring(10, 21);
      codigo[2] = codigoBoleto.substring(21, 32);
      codigo[3] = codigoBoleto.substring(32, 33);
      codigo[4] = codigoBoleto.substring(33);
    } else {
      codigo[0] = codigoBoleto.substring(0, 5);
      codigo[1] = codigoBoleto.substring(5, 19);
      codigo[2] = codigoBoleto.substring(19, 24);
      codigo[3] = codigoBoleto.substring(24, 30);
      codigo[4] = codigoBoleto.substring(30);
    }
    return codigo;
  }

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    model = model.copyWith(
      name: name,
      dueDate: dueDate,
      value: value,
      barcode: barcode,
    );
  }

  Future<void> saveBoleto() async {
    _isProcessing = true;
    input.add(_isProcessing);

    final instace = await SharedPreferences.getInstance();
    final boletos = instace.getStringList('boletos') ?? <String>[];
    boletos.add(model.toJson());
    await instace.setStringList('boletos', boletos);

    _isProcessing = false;
    input.add(_isProcessing);
  }

  Future<void> registerBoleto() async {
    final form = _formKey.currentState;

    if (form!.validate()) {
      await saveBoleto();
    }

    return;
  }

  dispose() {
    _streamController.close();
  }
}
