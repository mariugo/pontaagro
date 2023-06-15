import 'package:go_router/go_router.dart';
import 'package:pontaagro/features/farm_animals/presentation/pages/add_animals_page.dart';
import 'package:pontaagro/features/farm_animals/presentation/pages/farm_animals_page.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/presentation/pages/farms_page.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FarmsPage(),
    ),
    GoRoute(
        path: '/farm-animals',
        builder: (context, state) => FarmAnimalsPage(
              farm: state.extra as FarmsModel,
            )),
    GoRoute(
      path: '/add-animals',
      builder: ((context, state) => AddAnimalPage(
            farm: state.extra as FarmsModel,
          )),
    ),
  ],
);
