import 'dart:async';

import 'package:flutter/material.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertBoletoController {
  final _formKey = GlobalKey<FormState>();
  BoletoModel _boletoModel = BoletoModel();

  bool _isProcessing = false;

  final _streamController = StreamController<bool>();

  Sink<bool> get input => _streamController.sink;
  Stream<bool> get output => _streamController.stream;

  bool get isProcessing => _isProcessing;

  GlobalKey<FormState> get formKey => _formKey;

  String? validateName(String? value) {
    return value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  }

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

  void onChange({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
  }) {
    _boletoModel = _boletoModel.copyWith(
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
    boletos.add(_boletoModel.toJson());
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
