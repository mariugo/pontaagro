import 'package:flutter/material.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_controller.dart';
import 'package:pontaagro/features/farms/presentation/pages/farms_page.dart';
import 'package:provider/provider.dart';

class FarmsPageRouter {
  FarmsPageRouter._();

  static Widget get page => MultiProvider(
        providers: [
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
