import 'package:flutter/material.dart';
import 'package:only_subx_ui/shared/enums/enums.dart';
import 'package:uuid/uuid.dart';

class PaymentMethod {
  final String id;
  final String name;
  final PaymentMethodTypes type;
  final String? description;
  final Icon icon;

  PaymentMethod(
      {required this.id,
      required this.name,
      required this.type,
      this.description,
      required this.icon});

  factory PaymentMethod.basic({String? id,
      String? name,
      PaymentMethodTypes? type,
      String? description,
      Icon? icon}) => PaymentMethod(
      id: id ?? const Uuid().v4(),
      name: type?.name ?? PaymentMethodTypes.cash.name,
      type: type ?? PaymentMethodTypes.cash,
      description: description,
      icon: icon ?? const Icon(Icons.attach_money_outlined));
}
