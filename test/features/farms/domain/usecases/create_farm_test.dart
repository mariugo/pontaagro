import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/farms_repository_impl_test.mocks.dart';

void main() {
  FarmsModel farmsModelTest =
      const FarmsModel(name: 'Teste', id: 1, quantity: 10);
  late Database database;
  late MockFarmsRepositoryImpl mockFarmsRepositoryImpl;
  late CreateFarmUseCase createFarmUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockFarmsRepositoryImpl = MockFarmsRepositoryImpl();
    createFarmUseCase = CreateFarmUseCase(repository: mockFarmsRepositoryImpl);
    when(createFarmUseCase.call(farmsModelTest)).thenAnswer((_) async => 1);
  });

  tearDown(() async {
    await database.close();
  });

  group('CreateFarmUseCase', () {
    test('should return 1 when create farm', () async {
      final result = await createFarmUseCase.call(farmsModelTest);
      expect(result, 1);
    });

    test('should return DbException when create farm', () async {
      void mockDeleteError() {
        when(createFarmUseCase.call(farmsModelTest))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockDeleteError();
      expect(() => createFarmUseCase.call(farmsModelTest),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
