import 'dart:convert';
import 'package:uuid/uuid.dart';

class BoletoModel {
  final String _id;
  final String? name;
  final String? dueDate;
  final double? value;
  final String? barcode;
  bool isPaid;

  BoletoModel({
    this.name,
    this.dueDate,
    this.value,
    this.barcode,
    this.isPaid = false,
    String? id,
  }) : _id = id ?? const Uuid().v4();

  String get id => _id;

  setIsPaid(bool value) {
    isPaid = value;
  }

  BoletoModel copyWith({
    String? name,
    String? dueDate,
    double? value,
    String? barcode,
    bool isPaid = false,
  }) {
    return BoletoModel(
      name: name ?? this.name,
      dueDate: dueDate ?? this.dueDate,
      value: value ?? this.value,
      barcode: barcode ?? this.barcode,
      isPaid: isPaid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dueDate': dueDate,
      'value': value,
      'barcode': barcode,
      'isPaid': isPaid,
    };
  }

  factory BoletoModel.fromMap(Map<String, dynamic> map) {
    return BoletoModel(
      id: map['id'],
      name: map['name'],
      dueDate: map['dueDate'],
      value: map['value'],
      barcode: map['barcode'],
      isPaid: map['isPaid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BoletoModel.fromJson(String source) =>
      BoletoModel.fromMap(json.decode(source));
}
