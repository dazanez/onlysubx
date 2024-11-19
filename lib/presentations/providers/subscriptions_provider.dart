import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/domain/entities/entities.dart';

final subscriptionsProvider = StateProvider((ref) => List.filled(3, Subscription.example(), growable: true));
final currentSubscriptionProvider = StateProvider<Subscription?>((ref) => null);
