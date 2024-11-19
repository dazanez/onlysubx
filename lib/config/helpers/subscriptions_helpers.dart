import 'package:only_subx_ui/domain/entities/entities.dart';

class SubscriptionsHelpers {
  static List<Subscription> getPastSubscriptions(List<Subscription> subs) {
    return subs
        .where((sub) => sub.nextBillingDate.isBefore(DateTime.now()))
        .toList();
  }

  static double getSubscriptionsTotalCost(List<Subscription> subs) {
    double totalCost = 0;
    for (Subscription sub in subs) {
      totalCost += sub.value;
    }
    return totalCost;
  }

  static Subscription getMostExpensiveSub(List<Subscription> subs) {
    return subs.reduce((mostExpensiveSub, currentSub) =>
        currentSub.value > mostExpensiveSub.value
            ? currentSub
            : mostExpensiveSub);
  }

  static List<Subscription> getSubscriptionsForDay(
      List<Subscription> subs, DateTime day) {
    List<Subscription> events = [];
 
    for (Subscription sub in subs) {
      DateTime nextBillingDate = sub.nextBillingDate;
      if (nextBillingDate.year == day.year &&
          nextBillingDate.month == day.month &&
          nextBillingDate.day == day.day) {
            events.add(sub);
          }
    }

    return events;
  }
}
