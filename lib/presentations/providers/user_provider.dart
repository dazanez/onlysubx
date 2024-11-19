import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/domain/entities/user.dart';

final userProvider = StateProvider((ref) => User.example());
/*
// Definir el estado que mantendrá el usuario
class UserState {
  final User? user;

  UserState({this.user});

  // Método para actualizar el usuario
  UserState copyWith({User? user}) {
    return UserState(user: user ?? this.user);
  }
}

// Crear un StateNotifier para manejar el estado del usuario
class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(UserState());  // Inicia con un estado vacío

  // Método para establecer el usuario
  void setUser(User user) {
    state = state.copyWith(user: user);
  }

  // Método para obtener el usuario
  User? get user => state.user;

  // Método para limpiar el usuario (por ejemplo, al cerrar sesión)
  void clearUser() {
    state = state.copyWith(user: null);
  }
}

// Crear un Provider de tipo StateNotifierProvider
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier();
});
*/