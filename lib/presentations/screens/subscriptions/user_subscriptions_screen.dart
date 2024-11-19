import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/domain/entities/subscription.dart';
import 'package:only_subx_ui/presentations/providers/subscriptions_provider.dart';
import 'package:only_subx_ui/presentations/screens/subscriptions/custom_subscriptions_listview.dart';

class UserSubscriptionsScreen extends ConsumerWidget {
  static String name = 'user-suscriptions-screen';

  const UserSubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Subscription> subscriptions = ref.watch(subscriptionsProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlySubx',
          style: TextStyle(color: colors.onBackground),
        ),
      ),
      body: CustomSubscriptionsListView(title: 'Mis suscripciones', subscriptions: subscriptions),
    );
  }
}
