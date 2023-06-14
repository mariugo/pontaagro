import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/update_animal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/animals_repository_impl_test.mocks.dart';

void main() {
  AnimalsModel animalModel = const AnimalsModel(
    id: 1,
    name: 'Vaca',
    farmId: 1,
    tag: '123456789123456',
  );
  late Database database;
  late MockAnimalsRepositoryImpl mockAnimalsRepositoryImpl;
  late UpdateAnimalUseCase updateAnimalUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockAnimalsRepositoryImpl = MockAnimalsRepositoryImpl();
    updateAnimalUseCase =
        UpdateAnimalUseCase(repository: mockAnimalsRepositoryImpl);
    when(mockAnimalsRepositoryImpl.updateAnimal(any))
        .thenAnswer((_) async => 1);
  });

  tearDown(() async {
    await database.close();
  });

  group('UpdateAnimalUseCase', () {
    test('should update animal', () async {
      final result = await updateAnimalUseCase(animalModel);
      expect(result, 1);
    });

    test('should return DbException when update animal', () async {
      void mockUpdateAnimal() {
        when(mockAnimalsRepositoryImpl.updateAnimal(any))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockUpdateAnimal();
      expect(() async => await updateAnimalUseCase(animalModel),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
