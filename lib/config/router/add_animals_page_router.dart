import 'package:flutter/material.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/features/farm_animals/data/repository/animals_repository_impl.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/pages/add_animals_page.dart';
import 'package:provider/provider.dart';

class AddAnimalPageRouter {
  AddAnimalPageRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<AnimalsRepository>(
            create: (context) => AnimalsRepositoryImpl(
              database: context.read<DbHelper>(),
            ),
          ),
          Provider<CreateAnimalsListUseCase>(
            create: (context) => CreateAnimalsListUseCase(
              repository: context.read<AnimalsRepository>(),
            ),
          ),
          Provider<AddAnimalsController>(
            create: (context) => AddAnimalsController(
              context.read<CreateAnimalsListUseCase>(),
            ),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return AddAnimalPage(
            farm: args['farm'],
          );
        },
      );
}
