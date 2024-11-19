import 'package:flutter/material.dart';
import 'package:only_subx_ui/domain/entities/entities.dart';
import 'package:only_subx_ui/shared/enums/enums.dart';
import 'package:only_subx_ui/utils/randoms.dart';

class Subscription {
  /// An uuid is asigned
  final String id;
  final String name;
  final String? description;
  final String? notes;
  final Currency currency;
  final double value;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Date that the subscription started in
  final DateTime? startDate;
  final DateTime nextBillingDate;

  /// The days before the billing date to remind a subscription
  final DateTime reminderDays;
  final Status status;

  /// Date when the user canceled the sub, if aplies
  final DateTime? cancellationDate;

  /// Does the sub renew automatically?
  final bool isAutoRenew;
  final Frecuency frecuency;
  final PaymentMethod paymentMethod;
  final Category? category;
  final Icon icon;
  final bool isTrial;

  Subscription(
      {required this.id,
      required this.name,
      this.description,
      this.notes,
      required this.currency,
      required this.value,
      required this.createdAt,
      required this.updatedAt,
      this.startDate,
      required this.nextBillingDate,
      required this.reminderDays,
      required this.status,
      this.cancellationDate,
      required this.isAutoRenew,
      required this.frecuency,
      required this.paymentMethod,
      this.category,
      required this.icon,
      required this.isTrial});

  factory Subscription.basic(
          {required String name,
          String? description,
          String? notes,
          required Currency currency,
          required double value,
          DateTime? startDate,
          required DateTime nextBillingDate,
          required DateTime reminderDays,
          required Status status,
          DateTime? cancellationDate,
          required bool isAutoRenew,
          required Frecuency frecuency,
          required PaymentMethod paymentMethod,
          Category? category,
          Icon? icon,
          bool isTrial = false}) =>
      Subscription(
          id: Randoms.getUuid(),
          name: name,
          description: description,
          notes: notes,
          currency: currency,
          value: value,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          nextBillingDate: nextBillingDate,
          reminderDays: reminderDays,
          status: status,
          isAutoRenew: isAutoRenew,
          frecuency: frecuency,
          paymentMethod: paymentMethod,
          icon: icon ?? const Icon(Icons.subscriptions_outlined),
          isTrial: isTrial);

  factory Subscription.example() => Subscription.basic(
      name: 'Sub example',
      currency: Currency.cop,
      value: 10000,
      nextBillingDate: DateTime.now().add(const Duration(days: 30)),
      reminderDays: DateTime.now().add(const Duration(days: 3)),
      status: Status.active,
      isAutoRenew: true,
      frecuency: Frecuency.daily,
      paymentMethod: PaymentMethod.basic());
}
