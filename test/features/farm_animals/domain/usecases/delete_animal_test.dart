import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/delete_animal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/animals_repository_impl_test.mocks.dart';

void main() {
  late Database database;
  late MockAnimalsRepositoryImpl mockAnimalsRepositoryImpl;
  late DeleteAnimalUseCase deleteAnimalUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockAnimalsRepositoryImpl = MockAnimalsRepositoryImpl();
    deleteAnimalUseCase =
        DeleteAnimalUseCase(repository: mockAnimalsRepositoryImpl);
    when(mockAnimalsRepositoryImpl.deleteAnimal(any))
        .thenAnswer((_) async => 1);
  });

  tearDown(() async {
    await database.close();
  });

  group('DeleteAnimalUseCase', () {
    test('should delete animal', () async {
      final result = await deleteAnimalUseCase(1);
      expect(result, 1);
    });

    test('should return DbException when delete animal', () async {
      void mockDeleteAnimal() {
        when(mockAnimalsRepositoryImpl.deleteAnimal(any))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockDeleteAnimal();
      expect(() async => await deleteAnimalUseCase(1),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
