import 'package:flutter/material.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/pages/add_animals_page.dart';
import 'package:provider/provider.dart';

class AddAnimalPageRouter {
  AddAnimalPageRouter._();

  static Widget get page => MultiProvider(
        providers: [
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
