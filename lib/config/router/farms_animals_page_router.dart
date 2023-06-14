import 'package:flutter/material.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/features/farm_animals/data/repository/animals_repository_impl.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/delete_animal.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/get_animals_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/pages/farm_animals_page.dart';
import 'package:provider/provider.dart';

class FarmAnimalsPageRouter {
  FarmAnimalsPageRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<AnimalsRepository>(
            create: (context) => AnimalsRepositoryImpl(
              database: context.read<DbHelper>(),
            ),
          ),
          Provider<DeleteAnimalUseCase>(
            create: (context) => DeleteAnimalUseCase(
              repository: context.read<AnimalsRepository>(),
            ),
          ),
          Provider<GetAnimalsListUseCase>(
            create: (context) => GetAnimalsListUseCase(
              repository: context.read<AnimalsRepository>(),
            ),
          ),
          Provider<FarmAnimalsController>(
            create: (context) => FarmAnimalsController(
                context.read<GetAnimalsListUseCase>(),
                context.read<DeleteAnimalUseCase>()),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return FarmAnimalsPage(
            farm: args['farm'],
          );
        },
      );
}
