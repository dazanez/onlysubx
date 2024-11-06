import 'package:only_subx_ui/domain/entities/entities.dart';
import 'package:only_subx_ui/domain/entities/notifications_preferences.dart';
import 'package:only_subx_ui/shared/enums/enums.dart';
import 'package:uuid/uuid.dart';

enum AuthProvider { local, firebase, google, facebook, email }

class User {
  final String id;
  final String name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastLogin;
  final AuthProvider authProvider;
  final bool isPremium;
  final Currency preferredCurrency;
  final bool notificationsEnabled;
  final NotificationsPreferences notificationPreferences;
  final PaymentMethod defaultPaymentMethod;
  final Language language;
  final Role role;

  User({
    required this.id,
    required this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
    required this.authProvider,
    required this.isPremium,
    required this.preferredCurrency,
    required this.notificationsEnabled,
    required this.notificationPreferences,
    required this.defaultPaymentMethod,
    required this.language,
    required this.role,
  });

  factory User.basic({
    required String name,
    String? email,
    String? password,
    String? phoneNumber,
    String? photoUrl,
    required DateTime lastLogin,
    AuthProvider authProvider = AuthProvider.local,
    bool isPremium = false,
    required Currency preferredCurrency,
    bool notificationsEnabled = true,
    NotificationsPreferences? notificationPreferences,
    required PaymentMethod defaultPaymentMethod,
    Language language = Language.local,
    Role role = Role.user,
  }) {
    return User(
        id: const Uuid().v4(),
        name: name,
        email: email,
        password: password,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        lastLogin: lastLogin,
        authProvider: authProvider,
        phoneNumber: phoneNumber,
        photoUrl: photoUrl,
        isPremium: isPremium,
        preferredCurrency: preferredCurrency,
        notificationsEnabled: notificationsEnabled,
        notificationPreferences: notificationPreferences ?? NotificationsPreferences(),
        defaultPaymentMethod: defaultPaymentMethod,
        language: language,
        role: role);
  } 

  factory User.example() => User.basic(
      name: 'Diego Sanchez',
      photoUrl: 'https://wallpapers.com/images/featured/cool-profile-picture-87h46gcobjl5e4xu.jpg',
      isPremium: true,
      lastLogin: DateTime.now(),
      preferredCurrency: Currency.cop,
      defaultPaymentMethod: PaymentMethod.basic());
}
