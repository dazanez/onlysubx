import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class NewSubscriptionScreen extends StatelessWidget {
  static const name = 'new-sub-screen';

  const NewSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlySubx',
          style: TextStyle(color: colors.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nombre'),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el nombre de la sub';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Text('Descripción'),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa el nombre de la sub';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              const Text('Siguiente cobro'),
              const SizedBox(height: 10),
              InputDatePickerFormField(
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365*3)),
              ),
              const SizedBox(height: 30),
              DropdownButtonFormField(
                hint: const Text('Se renueva automáticamente', style: TextStyle(fontSize: 20),),
                items: const [
                DropdownMenuItem(value: 'Sí',child: Text('Sí'),),
                DropdownMenuItem(value: 'No', child: Text('No')),
              ],
              onChanged: (onChanged){}
              )
            ],
          ),
        ),
      ),
    );
  }
}
