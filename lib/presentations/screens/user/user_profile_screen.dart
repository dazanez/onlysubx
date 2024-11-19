import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:only_subx_ui/config/routes/routes.dart';
import 'package:only_subx_ui/domain/entities/entities.dart';
import 'package:only_subx_ui/presentations/providers/user_provider.dart';
import 'package:only_subx_ui/presentations/screens/subscriptions/subs_calendar_screen.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static String name = 'user-profile-screen';
  const UserProfileScreen({super.key});

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends ConsumerState<UserProfileScreen> {
  // Creamos un GlobalKey para el formulario
  final _formKey = GlobalKey<FormState>();

  // Variables para almacenar los datos del formulario
  late String _name;
  String? _email;
  String? _phoneNumber;
  String? _photoUrl;

  // Inicializamos con los datos actuales del usuario
  @override
  void initState() {
    super.initState();
    User user = ref.read(userProvider);
    // Supongamos que tienes una instancia de usuario llamada 'user'
    _name = user.name; // Esta sería la data de ejemplo
    _email = user.email;
    _phoneNumber = user.phoneNumber;
    _photoUrl = user.photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    User user = ref.watch(userProvider.notifier).state;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlySubx',
          style: TextStyle(color: colors.onBackground),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _name = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _email,
                    decoration:
                        const InputDecoration(labelText: 'Correo electrónico'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electrónico';
                      }
                      if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Por favor ingresa un correo electrónico válido';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _phoneNumber,
                    decoration:
                        const InputDecoration(labelText: 'Número de teléfono'),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      _phoneNumber = value;
                    },
                  ),
                  TextFormField(
                    initialValue: _photoUrl,
                    decoration: const InputDecoration(
                        labelText: 'Foto de perfil (URL)'),
                    onChanged: (value) {
                      _photoUrl = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Si el formulario es válido, actualizamos los datos
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Perfil actualizado')),
                          );

                          // Aquí llamarías a tu lógica para actualizar el usuario
                          ref.watch(userProvider.notifier).update((state) =>
                              User.basic(
                                  name: _name,
                                  email: _email,
                                  phoneNumber: _phoneNumber,
                                  photoUrl: _photoUrl,
                                  lastLogin: user.lastLogin,
                                  preferredCurrency: user.preferredCurrency,
                                  defaultPaymentMethod:
                                      user.defaultPaymentMethod));
                        }
                      },
                      child: const Text('Actualizar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
              width: double.infinity,
              height: 80,
              child: _MoreOptionsProfileView())
        ],
      ),
    );
  }
}

class _MoreOptionsProfileView extends ConsumerWidget {
  const _MoreOptionsProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.subscriptions),
          title: const Text('Mis suscripciones'),
          subtitle: const Text('Gestionar'),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => context.push(Routes.userSubscriptions),
        )
      ],
    );
  }
}
