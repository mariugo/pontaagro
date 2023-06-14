import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/farms_repository_impl_test.mocks.dart';

void main() {
  FarmsModel farmsModelTest =
      const FarmsModel(name: 'Teste', id: 1, quantity: 10);
  late Database database;
  late MockFarmsRepositoryImpl mockFarmsRepositoryImpl;
  late UpdateFarmUseCase updateFarmUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockFarmsRepositoryImpl = MockFarmsRepositoryImpl();
    updateFarmUseCase = UpdateFarmUseCase(repository: mockFarmsRepositoryImpl);
    when(mockFarmsRepositoryImpl.updateFarm(any)).thenAnswer((_) async => 1);
  });

  tearDown(() async {
    await database.close();
  });

  group('UpdateFarmUseCase', () {
    test('should update farm', () async {
      final result = await updateFarmUseCase(farmsModelTest);
      expect(result, 1);
    });

    test('should return DbException when update farm', () async {
      void mockUpdateFarm() {
        when(mockFarmsRepositoryImpl.updateFarm(any))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockUpdateFarm();
      expect(() async => await updateFarmUseCase(farmsModelTest),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
