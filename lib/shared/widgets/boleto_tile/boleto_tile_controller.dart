import 'dart:async';
import 'package:payflow/shared/models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoTileController {
  Future<void> deleteBoleto({required String id}) async {
    final instace = await SharedPreferences.getInstance();
    final boletos = instace.getStringList('boletos') ?? <String>[];
    List<String> list = <String>[];

    for (var boleto in boletos) {
      if (BoletoModel.fromJson(boleto).id != id) {
        list.add(boleto);
      }
    }

    await instace.setStringList('boletos', <String>[]);

    await instace.setStringList('boletos', list);
  }

  Future<void> payBoleto({required String id, BoletoModel? boleto}) async {
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList('boletos') ?? <String>[];
    boletos.removeWhere((element) => element == boleto!.toJson());
    boleto!.isPaid = true;
    boletos.insert(0, boleto.toJson());
    await instance.setStringList("boletos", boletos);
    return;
    //List<String> list = boletos;
    ////List<String> list = <String>[];
    //for (var boleto in list) {
    //  if (BoletoModel.fromJson(boleto).id == id) {
    //    BoletoModel.fromJson(boleto).setIsPaid(true);
    //    print('Passei o boleto para true');
    //  }
    //}

    //await instace.setStringList('boletos', <String>[]);

    //await instace.setStringList('boletos', list);
  }
}
