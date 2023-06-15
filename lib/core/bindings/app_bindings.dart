import 'package:flutter/material.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/features/farm_animals/data/repository/animals_repository_impl.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/delete_animal.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/get_animals_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_controller.dart';
import 'package:pontaagro/features/farms/data/repository/farms_repository_impl.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_controller.dart';
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
        Provider<FarmsRepository>(
          create: (context) => FarmsRepositoryImpl(
            database: context.read<DbHelper>(),
          ),
        ),
        Provider<AnimalsRepository>(
          create: (context) => AnimalsRepositoryImpl(
            database: context.read<DbHelper>(),
          ),
        ),
        Provider<GetFarmsUseCase>(
          create: (context) => GetFarmsUseCase(
            repository: context.read<FarmsRepository>(),
          ),
        ),
        Provider<CreateFarmUseCase>(
          create: (context) => CreateFarmUseCase(
            repository: context.read<FarmsRepository>(),
          ),
        ),
        Provider<DeleteFarmUseCase>(
          create: (context) => DeleteFarmUseCase(
            repository: context.read<FarmsRepository>(),
          ),
        ),
        Provider<UpdateFarmUseCase>(
          create: (context) => UpdateFarmUseCase(
            repository: context.read<FarmsRepository>(),
          ),
        ),
        Provider<GetAnimalsListUseCase>(
          create: (context) => GetAnimalsListUseCase(
            repository: context.read<AnimalsRepository>(),
          ),
        ),
        Provider<CreateAnimalsListUseCase>(
          create: (context) => CreateAnimalsListUseCase(
            repository: context.read<AnimalsRepository>(),
          ),
        ),
        Provider<DeleteAnimalUseCase>(
          create: (context) => DeleteAnimalUseCase(
            repository: context.read<AnimalsRepository>(),
          ),
        ),
        Provider<FarmsController>(
          create: (context) => FarmsController(
            context.read<CreateFarmUseCase>(),
            context.read<DeleteFarmUseCase>(),
            context.read<GetFarmsUseCase>(),
            context.read<UpdateFarmUseCase>(),
          ),
        ),
        Provider<FarmAnimalsController>(
          create: (context) => FarmAnimalsController(
              context.read<GetAnimalsListUseCase>(),
              context.read<DeleteAnimalUseCase>()),
        ),
        Provider<AddAnimalsController>(
          create: (context) => AddAnimalsController(
            context.read<CreateAnimalsListUseCase>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
