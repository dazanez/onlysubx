import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:only_subx_ui/config/helpers/human_formats.dart';
import 'package:only_subx_ui/config/routes/routes.dart';
import 'package:only_subx_ui/domain/entities/subscription.dart';
import 'package:only_subx_ui/presentations/providers/subscriptions_provider.dart';

class CustomSubscriptionsListView extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final List<Subscription> subscriptions;

  const CustomSubscriptionsListView(
      {super.key,
      required this.title,
      required this.subscriptions,
      this.subtitle = ''});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: subscriptions.length,
          itemBuilder: (context, index) =>
              _CustomSubscriptionListItem(subscription: subscriptions[index]),
        ),
      ],
    );
  }
}

class _CustomSubscriptionListItem extends ConsumerWidget {
  final Subscription subscription;
  const _CustomSubscriptionListItem({required this.subscription});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return InkWell(
      onTap: () {
        ref.read(currentSubscriptionProvider.notifier).update((state) => subscription);
        context.push(Routes.subscriptionDetails);
        },
      child: Container(
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
            ),
            const Spacer(),
            Positioned(
              right: 0,
              child: Text(
                '${subscription.value}',
                style: textStyle.titleMedium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
