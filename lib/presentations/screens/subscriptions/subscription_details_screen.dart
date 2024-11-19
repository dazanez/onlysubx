import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/domain/entities/payment_method.dart';
import 'package:only_subx_ui/domain/entities/subscription.dart';
import 'package:only_subx_ui/presentations/providers/subscriptions_provider.dart';
import 'package:only_subx_ui/shared/enums/enums.dart';

class SubscriptionDetailsScreen extends ConsumerStatefulWidget {
  static String name = 'subscription-details-screen';
  const SubscriptionDetailsScreen({super.key});

  @override
  _SubscriptionDetailsScreenState createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState
    extends ConsumerState<SubscriptionDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  Subscription? currentSubscription;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    
    currentSubscription = ref.read(currentSubscriptionProvider);

    _nameController.text = currentSubscription?.name ?? _nameController.text;
    _descriptionController.text =
        currentSubscription?.description ?? _descriptionController.text;
    _notesController.text = currentSubscription?.notes ?? _notesController.text;
    _valueController.text =
        currentSubscription?.value.toString() ?? _valueController.text;

    _nextBillingDate = currentSubscription?.nextBillingDate ?? _nextBillingDate;
    _reminderDays = currentSubscription?.reminderDays ?? _reminderDays;
    _startDate = currentSubscription?.startDate ?? _startDate;
    _cancellationDate =
        currentSubscription?.cancellationDate ?? _cancellationDate;

    _isAutoRenew = currentSubscription?.isAutoRenew ?? _isAutoRenew;
    _isTrial = currentSubscription?.isTrial ?? _isTrial;

    _frecuency = currentSubscription?.frecuency ?? _frecuency;
    _paymentMethod = currentSubscription?.paymentMethod.type ?? _paymentMethod;
  }

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
                      Subscription updatedSubscription = Subscription.basic(
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

                      if (currentSubscription != null) {
                        List<Subscription> subscriptions =
                            ref.watch(subscriptionsProvider);
                        int idxSubToUpdate = subscriptions.indexWhere(
                            (sub) => sub.id == currentSubscription?.id);
                        if (idxSubToUpdate >= 0) {
                          subscriptions[idxSubToUpdate] = updatedSubscription;
                          ref
                              .read(subscriptionsProvider.notifier)
                              .update((state) => [...subscriptions]);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Suscripción actualizada')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('No se ha encontrado la suscripción')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error obteniendo la suscripción')),
                        );
                      }
                    }
                  },
                  child: const Text('Actualizar Suscripción'),
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
