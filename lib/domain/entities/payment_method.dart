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

  factory PaymentMethod.basic() => PaymentMethod(
      id: const Uuid().v4(),
      name: PaymentMethodTypes.cash.toString(),
      type: PaymentMethodTypes.cash,
      description: null,
      icon: const Icon(Icons.attach_money_outlined));
}
