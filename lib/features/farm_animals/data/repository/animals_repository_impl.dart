import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/core/data/database/sql_script.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';
import 'package:sqflite/sqflite.dart';

class AnimalsRepositoryImpl implements AnimalsRepository {
  final DbHelper database;

  AnimalsRepositoryImpl({
    required this.database,
  });

  @override
  Future<int> deleteAnimal(int id) async {
    try {
      final db = await database.db;
      return await db.delete(
        animalTable,
        where: 'animal_id = ?',
        whereArgs: [id],
      );
    } catch (_) {
      throw const DbException(message: 'Erro ao deletar animal');
    }
  }

  @override
  Future<List<AnimalsModel>> getAnimals(int farmId) async {
    List<AnimalsModel> animals = [];
    try {
      final db = await database.db;
      final maps = await db.query(
        animalTable,
        where: 'animal_farm_id = ?',
        whereArgs: [farmId],
      );
      if (maps.isNotEmpty) {
        animals = maps.map((animal) => AnimalsModel.fromJson(animal)).toList();
      }
      return animals;
    } catch (_) {
      throw const DbException(message: 'Erro ao buscar animais');
    }
  }

  @override
  Future<int> updateAnimal(AnimalsModel animal) async {
    try {
      final db = await database.db;
      return await db.update(
        animalTable,
        animal.toJson(),
        where: 'animal_id = ?',
        whereArgs: [animal.id],
      );
    } catch (_) {
      throw const DbException(message: 'Erro ao atualizar animal');
    }
  }

  @override
  Future<bool> createAnimalList(List<AnimalsModel> animal) async {
    try {
      if (animal.isNotEmpty) {
        final db = await database.db;
        final batch = db.batch();
        for (var i in animal) {
          batch.insert(
            animalTable,
            i.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
        return true;
      }
      return false;
    } catch (_) {
      throw const DbException(message: 'Erro ao criar lista de animais');
    }
  }
}
