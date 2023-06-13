import 'package:flutter/material.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/features/farms/data/repository/farms_repository_impl.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
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
      ],
      child: child,
    );
  }
}
