import 'package:flutter/material.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:provider/provider.dart';

class AppBindings extends StatelessWidget {
  final Widget child;

  const AppBindings({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbHelper>(
          create: (context) => DbHelper(),
        ),
      ],
      child: child,
    );
  }
}
