import 'package:flutter/material.dart';
import 'package:pontaagro/config/di/locator.dart';
import 'package:pontaagro/features/app.dart';

void main() {
  initializeDependencyInjection();
  runApp(const App());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBindings(
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Ponta >>',
//         theme: ThemeData(
//           textTheme: AppTextTheme.lightTextTheme,
//           useMaterial3: true,
//           colorScheme: lightColorScheme,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         darkTheme: ThemeData(
//           textTheme: AppTextTheme.darkTextTheme,
//           useMaterial3: true,
//           colorScheme: darkColorScheme,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         routes: {
//           '/': (context) => FarmsPageRouter.page,
//           '/farm-animals': (context) => FarmAnimalsPageRouter.page,
//           '/add-animals': (context) => AddAnimalPageRouter.page,
//         },
//       ),
//     );
//   }
// }
