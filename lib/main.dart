import 'package:flutter/material.dart';
import 'package:only_subx_ui/config/helpers/human_formats.dart';
import 'package:only_subx_ui/config/router/app_router.dart';
import 'package:only_subx_ui/config/theme/app_theme.dart';
// main is async to use dotenv
main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(HumanFormats.humanReadableDate(DateTime.now()));
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 3, isDarkMode: false).getTheme(),
    );
  }
}
