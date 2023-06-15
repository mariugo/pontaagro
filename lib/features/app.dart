import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pontaagro/config/router/routes.dart';
import 'package:pontaagro/config/theme/app_colors.dart';
import 'package:pontaagro/config/theme/app_text_theme.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/delete_animal.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/get_animals_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_controller.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FarmsController>(
          create: (context) => FarmsController(
            createFarmUseCase: GetIt.I.get<CreateFarmUseCase>(),
            deleteFarmUseCase: GetIt.I.get<DeleteFarmUseCase>(),
            getFarmsUseCase: GetIt.I.get<GetFarmsUseCase>(),
            updateFarmUseCase: GetIt.I.get<UpdateFarmUseCase>(),
          ),
        ),
        BlocProvider<FarmAnimalsController>(
          create: (context) => FarmAnimalsController(
            getAnimalsListUseCase: GetIt.I.get<GetAnimalsListUseCase>(),
            deleteAnimalUseCase: GetIt.I.get<DeleteAnimalUseCase>(),
          ),
        ),
        BlocProvider<AddAnimalsController>(
          create: (context) => AddAnimalsController(
            createAnimalsListUseCase: GetIt.I.get<CreateAnimalsListUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: routes,
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
      ),
    );
  }
}
