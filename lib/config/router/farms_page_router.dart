import 'package:flutter/material.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_controller.dart';
import 'package:pontaagro/features/farms/presentation/pages/farms_page.dart';
import 'package:pontaagro/features/farms/data/repository/farms_repository_impl.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:provider/provider.dart';

class FarmsPageRouter {
  FarmsPageRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<FarmsRepository>(
            create: (context) => FarmsRepositoryImpl(
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
          Provider<FarmsController>(
            create: (context) => FarmsController(
              context.read<CreateFarmUseCase>(),
              context.read<DeleteFarmUseCase>(),
              context.read<GetFarmsUseCase>(),
              context.read<UpdateFarmUseCase>(),
            ),
          ),
        ],
        child: const FarmsPage(),
      );
}
