import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/domain/entities/payment_method.dart';
import 'package:only_subx_ui/domain/entities/subscription.dart';
import 'package:only_subx_ui/presentations/providers/subscriptions_provider.dart';
import 'dart:async';

import 'package:only_subx_ui/shared/enums/enums.dart'; // Para manejar las fechas

class NewSubscriptionScreen extends ConsumerStatefulWidget {
  static const name = 'subscription-screen';

  const NewSubscriptionScreen({super.key});

  @override
  _NewSubscriptionScreenState createState() => _NewSubscriptionScreenState();
}

class _NewSubscriptionScreenState extends ConsumerState<NewSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  DateTime _nextBillingDate = DateTime.now();
  DateTime _reminderDays = DateTime.now();
  DateTime? _startDate;
  DateTime? _cancellationDate;

  bool _isAutoRenew = false;
  bool _isTrial = false;

  // Aquí tendrías tus opciones de Currency, Frecuency, PaymentMethod, etc.
  final Currency _currency = Currency.usd;
  Frecuency _frecuency = Frecuency.monthly;
  PaymentMethodTypes _paymentMethod = PaymentMethodTypes.cash;
  final Status _status = Status.active;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Suscripción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para nombre
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              // Campo para descripción
              TextFormField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Descripción (opcional)'),
              ),
              // Campo para notas
              TextFormField(
                controller: _notesController,
                decoration:
                    const InputDecoration(labelText: 'Notas (opcional)'),
              ),
              // Campo para valor
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final isNumeric =
                      double.tryParse(value ?? '') != null ? true : false;
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un valor';
                  } else if (!isNumeric) {
                    return 'Ingresa un numero valido';
                  }
                  return null;
                },
              ),
              // Selector para fecha de inicio (opcional)
              ListTile(
                title: const Text('Fecha de inicio'),
                subtitle: Text(_startDate == null
                    ? 'Selecciona una fecha'
                    : _startDate!.toLocal().toString().split(' ')[0]),
                onTap: () => _selectDate(context, true),
              ),
              // Selector para fecha de siguiente facturación
              ListTile(
                title: const Text('Próxima facturación'),
                subtitle:
                    Text(_nextBillingDate.toLocal().toString().split(' ')[0]),
                onTap: () => _selectDate(context, false),
              ),
              // Selector para fecha de recordatorio
              ListTile(
                title:
                    const Text('Días de recordatorio antes de la facturación'),
                subtitle:
                    Text(_reminderDays.toLocal().toString().split(' ')[0]),
                onTap: () => _selectReminderDate(context),
              ),
              // Selector de frecuencia
              DropdownButtonFormField<Frecuency>(
                value: _frecuency,
                decoration: const InputDecoration(labelText: 'Frecuencia'),
                items: Frecuency.values.map((Frecuency freq) {
                  return DropdownMenuItem<Frecuency>(
                    value: freq,
                    child: Text(freq.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _frecuency = value!;
                  });
                },
              ),
              // Selector de método de pago
              DropdownButtonFormField<PaymentMethodTypes>(
                value: _paymentMethod,
                decoration: const InputDecoration(labelText: 'Método de pago'),
                items: PaymentMethodTypes.values.map((PaymentMethodTypes type) {
                  return DropdownMenuItem<PaymentMethodTypes>(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value!;
                  });
                },
              ),
              // Checkbox para auto-renovación
              SwitchListTile(
                title: const Text('¿Auto-renovación?'),
                value: _isAutoRenew,
                onChanged: (value) {
                  setState(() {
                    _isAutoRenew = value;
                  });
                },
              ),
              // Checkbox para prueba
              SwitchListTile(
                title: const Text('¿Es una prueba del servicio?'),
                value: _isTrial,
                onChanged: (value) {
                  setState(() {
                    _isTrial = value;
                  });
                },
              ),
              // Botón de envío
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Crear una nueva suscripción con los datos del formulario
                      Subscription newSubscription = Subscription.basic(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        notes: _notesController.text,
                        currency: _currency,
                        value: double.parse(_valueController.text),
                        startDate: _startDate,
                        nextBillingDate: _nextBillingDate,
                        reminderDays: _reminderDays,
                        status: _status,
                        isAutoRenew: _isAutoRenew,
                        frecuency: _frecuency,
                        paymentMethod:
                            PaymentMethod.basic(type: _paymentMethod),
                        isTrial: _isTrial,
                      );
                      ref
                          .read(subscriptionsProvider.notifier).update((state) => [...state, newSubscription]);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Suscripción creada con éxito')),
                      );
                    }
                  },
                  child: const Text('Crear Suscripción'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para seleccionar una fecha (utilizado para las fechas de inicio y de facturación)
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate ? _startDate ?? DateTime.now() : _nextBillingDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != (isStartDate ? _startDate : _nextBillingDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _nextBillingDate = picked;
        }
      });
    }
  }

  // Método para seleccionar la fecha de recordatorio
  Future<void> _selectReminderDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _reminderDays,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _reminderDays) {
      setState(() {
        _reminderDays = picked;
      });
    }
  }
}
