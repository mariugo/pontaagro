import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
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
  late CreateAnimalsListUseCase createAnimalsListUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockAnimalsRepositoryImpl = MockAnimalsRepositoryImpl();
    createAnimalsListUseCase =
        CreateAnimalsListUseCase(repository: mockAnimalsRepositoryImpl);
    when(mockAnimalsRepositoryImpl.createAnimalList([animalModel]))
        .thenAnswer((_) async => true);
  });

  tearDown(() async {
    await database.close();
  });

  group('CreateAnimalsListUseCase', () {
    test('Should create a list of animals', () async {
      final result = await createAnimalsListUseCase([animalModel]);
      expect(result, true);
    });

    test('Should return a DBException when create a list of animals', () async {
      void mockCreateAnimalList() {
        when(mockAnimalsRepositoryImpl.createAnimalList([animalModel]))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockCreateAnimalList();
      expect(() async => await createAnimalsListUseCase([animalModel]),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
