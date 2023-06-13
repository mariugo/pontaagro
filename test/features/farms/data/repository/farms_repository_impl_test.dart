import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/core/data/database/sql_script.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/data/repository/farms_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'farms_repository_impl_test.mocks.dart';

@GenerateMocks([FarmsRepositoryImpl])
void main() {
  FarmsModel farmsModelTest = const FarmsModel(
    name: 'Teste',
    id: 1,
    quantity: 10,
  );
  List<FarmsModel> farmsModelListTest =
      List.generate(10, (index) => farmsModelTest);
  late Database database;
  late MockFarmsRepositoryImpl mockFarmsRepositoryImpl;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await database.execute(farmTableScript);
    mockFarmsRepositoryImpl = MockFarmsRepositoryImpl();
    when(mockFarmsRepositoryImpl.createFarm(farmsModelTest))
        .thenAnswer((_) async => 1);
    when(mockFarmsRepositoryImpl.getFarms())
        .thenAnswer((_) async => farmsModelListTest);
    when(mockFarmsRepositoryImpl.updateFarm(farmsModelTest))
        .thenAnswer((_) async => 1);
    when(mockFarmsRepositoryImpl.deleteFarm(1)).thenAnswer((_) async => 1);
  });

  tearDown(() async {
    await database.close();
  });

  test('Should return a list of 10 farms', () async {
    final result = await mockFarmsRepositoryImpl.getFarms();
    expect(result.length, 10);
  });

  test('Should create a farm', () async {
    final result = await mockFarmsRepositoryImpl.createFarm(farmsModelTest);
    expect(result, 1);
  });
  test('Should delete a farm', () async {
    final result = await mockFarmsRepositoryImpl.deleteFarm(1);
    expect(result, 1);
  });
  test('Should update a farm', () async {
    final result = await mockFarmsRepositoryImpl.updateFarm(farmsModelTest);
    expect(result, 1);
  });
}
