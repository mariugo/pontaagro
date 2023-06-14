import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/core/data/database/sql_script.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/data/repository/animals_repository_impl.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'animals_repository_impl_test.mocks.dart';

@GenerateMocks([AnimalsRepositoryImpl])
void main() {
  AnimalsModel animalModel = const AnimalsModel(
    id: 1,
    name: 'Vaca',
    farmId: 1,
    tag: '123456789123456',
  );
  List<AnimalsModel> animalsModel = List.generate(10, (index) => animalModel);
  late Database database;
  late MockAnimalsRepositoryImpl mockAnimalsRepositoryImpl;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockAnimalsRepositoryImpl = MockAnimalsRepositoryImpl();
    await database.execute(animalTableScript);
    when(mockAnimalsRepositoryImpl.getAnimals(1))
        .thenAnswer((_) async => animalsModel);
    when(mockAnimalsRepositoryImpl.deleteAnimal(1)).thenAnswer((_) async => 1);
    when(mockAnimalsRepositoryImpl.updateAnimal(animalModel))
        .thenAnswer((_) async => 1);
    when(mockAnimalsRepositoryImpl.createAnimalList(animalsModel))
        .thenAnswer((_) async => true);
  });

  tearDown(() async {
    await database.close();
  });

  test('Should return a list of animals', () async {
    final result = await mockAnimalsRepositoryImpl.getAnimals(1);
    expect(result, animalsModel);
  });
  test('Should return a list of 10 animals', () async {
    final result = await mockAnimalsRepositoryImpl.getAnimals(1);
    expect(result.length, 10);
  });

  test('Should create a list of animals', () async {
    final result =
        await mockAnimalsRepositoryImpl.createAnimalList(animalsModel);
    expect(result, true);
  });

  test('Should delete an animal', () async {
    final result = await mockAnimalsRepositoryImpl.deleteAnimal(1);
    expect(result, 1);
  });

  test('Should update an animal', () async {
    final result = await mockAnimalsRepositoryImpl.updateAnimal(animalModel);
    expect(result, 1);
  });

  test('Should return DbException when create farm', () async {
    void mockDeleteError() {
      when(mockAnimalsRepositoryImpl.createAnimalList(animalsModel))
          .thenThrow(const DbException(message: 'Error'));
    }

    mockDeleteError();
    expect(() => mockAnimalsRepositoryImpl.createAnimalList(animalsModel),
        throwsA(const DbException(message: 'Error')));
  });

  test('Should return DbException when delete farm', () async {
    void mockDeleteError() {
      when(mockAnimalsRepositoryImpl.deleteAnimal(1))
          .thenThrow(const DbException(message: 'Error'));
    }

    mockDeleteError();
    expect(() => mockAnimalsRepositoryImpl.deleteAnimal(1),
        throwsA(const DbException(message: 'Error')));
  });

  test('Should return DbException when update farm', () async {
    void mockDeleteError() {
      when(mockAnimalsRepositoryImpl.updateAnimal(animalModel))
          .thenThrow(const DbException(message: 'Error'));
    }

    mockDeleteError();
    expect(() => mockAnimalsRepositoryImpl.updateAnimal(animalModel),
        throwsA(const DbException(message: 'Error')));
  });

  test('Should return DbException when get animals', () async {
    void mockDeleteError() {
      when(mockAnimalsRepositoryImpl.getAnimals(1))
          .thenThrow(const DbException(message: 'Error'));
    }

    mockDeleteError();
    expect(() => mockAnimalsRepositoryImpl.getAnimals(1),
        throwsA(const DbException(message: 'Error')));
  });
}
