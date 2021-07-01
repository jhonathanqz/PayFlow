import 'package:flutter/cupertino.dart';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  List<BoletoModel> get boletos => boletosNotifier.value;
  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController({bool onlyPayed = false}) {
    getBoletos(onlyPayed);
  }

  Future<void> getBoletos(bool onlyPayed) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('boletos') ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
      boletos.removeWhere((element) => element.isPaid == !onlyPayed);
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }
}
