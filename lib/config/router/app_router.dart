import 'package:go_router/go_router.dart';
import 'package:only_subx_ui/config/routes/routes.dart';
import 'package:only_subx_ui/presentations/screens/screens.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.newSub,
      name: NewSubscriptionScreen.name,
      builder: (context, state) => const NewSubscriptionScreen(),
      ),
    GoRoute(
      path: Routes.subsCalendar,
      name: SubsCalendarScreen.name,
      builder: (context, state) => const SubsCalendarScreen(),
      ),
    GoRoute(
      path: Routes.userProfile,
      name: UserProfileScreen.name,
      builder: (context, state) => const UserProfileScreen(),
      ),
    GoRoute(
      path: Routes.userSubscriptions,
      name: UserSubscriptionsScreen.name,
      builder: (context, state) => const UserSubscriptionsScreen(),
      ),
    GoRoute(
      path: Routes.subscriptionDetails,
      name: SubscriptionDetailsScreen.name,
      builder: (context, state) => const SubscriptionDetailsScreen(),
      ),
  ],
);
