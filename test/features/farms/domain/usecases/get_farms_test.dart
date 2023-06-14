import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/farms_repository_impl_test.mocks.dart';

void main() {
  FarmsModel farmsModelTest =
      const FarmsModel(name: 'Teste', id: 1, quantity: 10);
  List<FarmsModel> farmsModelListTest =
      List.generate(10, (index) => farmsModelTest);
  late Database database;
  late MockFarmsRepositoryImpl mockFarmsRepositoryImpl;
  late GetFarmsUseCase getFarmsUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockFarmsRepositoryImpl = MockFarmsRepositoryImpl();
    getFarmsUseCase = GetFarmsUseCase(repository: mockFarmsRepositoryImpl);
    when(mockFarmsRepositoryImpl.getFarms())
        .thenAnswer((_) async => farmsModelListTest);
  });

  tearDown(() async {
    await database.close();
  });

  group('GetFarmsUseCase', () {
    test('Should return a list of 10 farms', () async {
      final result = await getFarmsUseCase(null);
      expect(result.length, 10);
    });

    test('Should return DbException when get farms', () async {
      void mockGetFarms() {
        when(mockFarmsRepositoryImpl.getFarms())
            .thenThrow(const DbException(message: 'Error'));
      }

      mockGetFarms();
      expect(() async => await getFarmsUseCase(null),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
