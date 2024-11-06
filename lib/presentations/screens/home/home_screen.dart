import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:only_subx_ui/config/helpers/human_formats.dart';
import 'package:only_subx_ui/config/routes/routes.dart';
import 'package:only_subx_ui/domain/entities/entities.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
            _WelcomeView(user: User.example()),
            _CardSummaryView(),
            _ActionButtons(),
            const _PaymentsListView(
              title: 'Recent',
            ),
            // const _PaymentsListView(title: 'Recent payments')
          ],
        ),
      ),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  final User user;
  const _WelcomeView({required this.user});

  @override
  Widget build(BuildContext context) {
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
          CircleAvatar(
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
          )
        ],
      ),
    );
  }
}

class _CardSummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    String yearlyAccValue = '****';

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
                  '\$149.900',
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
                    Text('Smart Fit', style: textStyle.titleMedium),
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

class _PaymentsListView extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _PaymentsListView({required this.title, this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final Subscription subscription = Subscription.example();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: textStyle.bodyMedium),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: textStyle.bodyMedium,
                )
            ],
          ),
        ),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
            _CustomSubscriptionListItem(subscription: subscription),
          ],
        ),
      ],
    );
  }
}

class _CustomSubscriptionListItem extends StatelessWidget {
  final Subscription subscription;
  const _CustomSubscriptionListItem({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: 80,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: colors.secondary))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                color: colors.onInverseSurface,
                borderRadius: BorderRadius.circular(8)),
            child: Icon(
              subscription.icon.icon,
              size: 50,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subscription.name,
                style: textStyle.titleSmall,
              ),
              Text(
                HumanFormats.humanReadableDate(subscription.nextBillingDate),
                style: textStyle.bodyMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}
