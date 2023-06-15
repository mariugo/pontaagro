import 'package:get_it/get_it.dart';
import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/features/farm_animals/data/repository/animals_repository_impl.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/delete_animal.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/get_animals_list.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/update_animal.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_controller.dart';
import 'package:pontaagro/features/farms/data/repository/farms_repository_impl.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_controller.dart';

final sl = GetIt.instance;

void initializeDependencyInjection() {
  _registerDataBase();
  _registerRepositories();
  _registerFarmUseCases();
  _registerAnimalUseCases();
  _registerControllers();
}

void _registerDataBase() {
  sl.registerLazySingleton<DbHelper>(() => DbHelper());
}

void _registerRepositories() {
  sl.registerLazySingleton<FarmsRepository>(
    () => FarmsRepositoryImpl(
      database: sl<DbHelper>(),
    ),
  );
  sl.registerLazySingleton<AnimalsRepository>(
    () => AnimalsRepositoryImpl(
      database: sl<DbHelper>(),
    ),
  );
}

// Farm UseCases
void _registerFarmUseCases() {
  sl.registerLazySingleton<CreateFarmUseCase>(
    () => CreateFarmUseCase(
      repository: sl<FarmsRepository>(),
    ),
  );
  sl.registerLazySingleton<DeleteFarmUseCase>(
    () => DeleteFarmUseCase(
      repository: sl<FarmsRepository>(),
    ),
  );
  sl.registerLazySingleton<GetFarmsUseCase>(
    () => GetFarmsUseCase(
      repository: sl<FarmsRepository>(),
    ),
  );
  sl.registerLazySingleton<UpdateFarmUseCase>(
    () => UpdateFarmUseCase(
      repository: sl<FarmsRepository>(),
    ),
  );
}

// Animal UseCases
void _registerAnimalUseCases() {
  sl.registerLazySingleton<CreateAnimalsListUseCase>(
    () => CreateAnimalsListUseCase(
      repository: sl<AnimalsRepository>(),
    ),
  );
  sl.registerLazySingleton<DeleteAnimalUseCase>(
    () => DeleteAnimalUseCase(
      repository: sl<AnimalsRepository>(),
    ),
  );
  sl.registerLazySingleton<GetAnimalsListUseCase>(
    () => GetAnimalsListUseCase(
      repository: sl<AnimalsRepository>(),
    ),
  );
  sl.registerLazySingleton<UpdateAnimalUseCase>(
    () => UpdateAnimalUseCase(
      repository: sl<AnimalsRepository>(),
    ),
  );
}

// Controllers
void _registerControllers() {
  sl.registerLazySingleton<FarmsController>(
    () => FarmsController(
      createFarmUseCase: sl<CreateFarmUseCase>(),
      deleteFarmUseCase: sl<DeleteFarmUseCase>(),
      getFarmsUseCase: sl<GetFarmsUseCase>(),
      updateFarmUseCase: sl<UpdateFarmUseCase>(),
    ),
  );
  sl.registerLazySingleton<FarmAnimalsController>(
    () => FarmAnimalsController(
      getAnimalsListUseCase: sl<GetAnimalsListUseCase>(),
      deleteAnimalUseCase: sl<DeleteAnimalUseCase>(),
    ),
  );
  sl.registerLazySingleton<AddAnimalsController>(
    () => AddAnimalsController(
      createAnimalsListUseCase: sl<CreateAnimalsListUseCase>(),
    ),
  );
}
