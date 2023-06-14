import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/get_animals_list.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../data/repository/animals_repository_impl_test.mocks.dart';

void main() {
  AnimalsModel animalModel = const AnimalsModel(
    id: 1,
    name: 'Vaca',
    farmId: 1,
    tag: '123456789123456',
  );
  List<AnimalsModel> animalsList = List.generate(10, (index) => animalModel);
  late Database database;
  late MockAnimalsRepositoryImpl mockAnimalsRepositoryImpl;
  late GetAnimalsListUseCase getAnimalsListUseCase;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockAnimalsRepositoryImpl = MockAnimalsRepositoryImpl();
    getAnimalsListUseCase =
        GetAnimalsListUseCase(repository: mockAnimalsRepositoryImpl);
    when(mockAnimalsRepositoryImpl.getAnimals(any))
        .thenAnswer((_) async => animalsList);
  });

  tearDown(() async {
    await database.close();
  });

  group('GetAnimalsListUseCase', () {
    test('should return list of animals', () async {
      final result = await getAnimalsListUseCase(1);
      expect(result, animalsList);
    });

    test('should return DbException when get animals', () async {
      void mockGetAnimals() {
        when(mockAnimalsRepositoryImpl.getAnimals(any))
            .thenThrow(const DbException(message: 'Error'));
      }

      mockGetAnimals();
      expect(() async => await getAnimalsListUseCase(1),
          throwsA(const DbException(message: 'Error')));
    });
  });
}
