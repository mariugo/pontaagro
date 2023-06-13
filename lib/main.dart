import 'package:flutter/material.dart';
import 'package:pontaagro/config/router/farms_page_router.dart';
import 'package:pontaagro/config/theme/app_colors.dart';
import 'package:pontaagro/config/theme/app_text_theme.dart';
import 'package:pontaagro/core/bindings/app_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBindings(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ponta >>',
        theme: ThemeData(
          textTheme: AppTextTheme.lightTextTheme,
          useMaterial3: true,
          colorScheme: lightColorScheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData(
          textTheme: AppTextTheme.darkTextTheme,
          useMaterial3: true,
          colorScheme: darkColorScheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => FarmsPageRouter.page,
        },
      ),
    );
  }
}
