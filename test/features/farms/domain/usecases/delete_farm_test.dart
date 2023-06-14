import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/farms_repository_impl_test.mocks.dart';

void main() {
  late Database database;
  late MockFarmsRepositoryImpl mockFarmsRepositoryImpl;
  late DeleteFarmUseCase deleteFarmUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockFarmsRepositoryImpl = MockFarmsRepositoryImpl();
    deleteFarmUseCase = DeleteFarmUseCase(repository: mockFarmsRepositoryImpl);
    when(mockFarmsRepositoryImpl.deleteFarm(any)).thenAnswer((_) async => 1);
  });

  tearDown(() async {
    await database.close();
  });

  group('DeleteFarmUseCase', () {
    test('should delete farm', () async {
      final result = await deleteFarmUseCase(1);
      expect(result, 1);
    });

    test('should return DbException when delete farm', () async {
      void mockDeleteFarm() {
        when(mockFarmsRepositoryImpl.deleteFarm(any))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockDeleteFarm();
      expect(() async => await deleteFarmUseCase(1),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
