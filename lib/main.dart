import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:only_subx_ui/config/router/app_router.dart';
import 'package:only_subx_ui/config/theme/app_theme.dart';
// main is async to use dotenv
main() => runApp(const ProviderScope(child: MainApp()));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1, isDarkMode: false).getTheme(),
    );
  }
}
