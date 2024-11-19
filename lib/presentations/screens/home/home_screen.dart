import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:only_subx_ui/config/helpers/human_formats.dart';
import 'package:only_subx_ui/config/helpers/subscriptions_helpers.dart';
import 'package:only_subx_ui/config/routes/routes.dart';
import 'package:only_subx_ui/domain/entities/entities.dart';
import 'package:only_subx_ui/presentations/providers/subscriptions_provider.dart';
import 'package:only_subx_ui/presentations/providers/user_provider.dart';
import 'package:only_subx_ui/presentations/screens/subscriptions/custom_subscriptions_listview.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final List<Subscription> subscriptions =
        SubscriptionsHelpers.getPastSubscriptions(
            ref.watch(subscriptionsProvider));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlySubx',
          style: TextStyle(color: colors.onBackground),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _WelcomeView(),
            _CardSummaryView(),
            _ActionButtons(),
            CustomSubscriptionsListView(
              title: 'Recientes',
              subscriptions: subscriptions,
            ),
            // const _PaymentsListView(title: 'Recent payments')
          ],
        ),
      ),
    );
  }
}

class _WelcomeView extends ConsumerWidget {
  // final User user;
  const _WelcomeView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(userProvider);
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hola,',
                style: textStyle.titleSmall,
              ),
              Text(
                user.name,
                style: textStyle.titleMedium,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.workspace_premium_outlined,
                    color: Colors.amber,
                  ),
                  Text(
                    user.isPremium ? 'Golden Subx' : 'Freemium',
                    style:
                        textStyle.titleSmall?.copyWith(color: colors.primary),
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => context.push(Routes.userProfile),
            child: CircleAvatar(
              radius: 50,
              // backgroundImage: NetworkImage(user.photoUrl ?? 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'),
              foregroundImage: NetworkImage(user.photoUrl ??
                  'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-800x525.jpg'),
              child: Text(
                user.name,
                style: textStyle.titleSmall,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CardSummaryView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    String yearlyAccValue = '****';
    List<Subscription> subscriptions = ref.watch(subscriptionsProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      color: colors.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  '${SubscriptionsHelpers.getSubscriptionsTotalCost(subscriptions)}',
                  style: textStyle.titleLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Total suscripciones',
                  style: textStyle.titleSmall
                      ?.copyWith(color: colors.onSecondaryContainer),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          yearlyAccValue,
                          style: textStyle.titleMedium,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ],
                    ),
                    Text(
                      'Acumulado anual',
                      style: textStyle.titleSmall
                          ?.copyWith(color: colors.onSecondaryContainer),
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(SubscriptionsHelpers.getMostExpensiveSub(subscriptions).name, style: textStyle.titleMedium),
                    const SizedBox(height: 10),
                    Text('Más costosa',
                        style: textStyle.titleSmall
                            ?.copyWith(color: colors.onSecondaryContainer)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                context.push(Routes.newSub);
              },
              icon: const Icon(Icons.add_circle_outline),
              iconSize: 50,
            ),
            Text(
              'Nueva sub',
              style: textStyle.titleSmall,
            )
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                context.push(Routes.subsCalendar);
              },
              icon: const Icon(Icons.calendar_month_outlined),
              iconSize: 50,
            ),
            Text(
              'Calendario subx',
              style: textStyle.titleSmall,
            )
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
              iconSize: 50,
            ),
            Text(
              'Próximas',
              style: textStyle.titleSmall,
            )
          ],
        ),
      ],
    );
  }
}



