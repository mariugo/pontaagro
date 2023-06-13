import 'package:pontaagro/core/data/database/db_helper.dart';
import 'package:pontaagro/core/data/database/sql_script.dart';
import 'package:pontaagro/core/data/errors/db_exception.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';

class FarmsRepositoryImpl implements FarmsRepository {
  final DbHelper database;

  FarmsRepositoryImpl({
    required this.database,
  });

  @override
  Future<int> createFarm(FarmsModel farm) async {
    try {
      final db = await database.db;
      return await db.insert(farmTable, farm.toJson());
    } catch (e) {
      throw const DbException(message: 'Erro ao criar fazenda');
    }
  }

  @override
  Future<int> deleteFarm(int id) async {
    try {
      final db = await database.db;
      return await db.delete(
        farmTable,
        where: 'farm_id = ?',
        whereArgs: [id],
      );
    } catch (_) {
      throw const DbException(message: 'Erro ao deletar fazenda');
    }
  }

  @override
  Future<List<FarmsModel>> getFarms() async {
    List<FarmsModel> farms = [];
    try {
      final db = await database.db;
      final maps = await db.rawQuery(selectFarmTableScript);
      if (maps.isNotEmpty) {
        farms = maps.map((e) => FarmsModel.fromJson(e)).toList();
      }
      return farms;
    } catch (_) {
      throw const DbException(message: 'Erro ao carregar fazendas');
    }
  }

  @override
  Future<int> updateFarm(FarmsModel farm) async {
    try {
      final db = await database.db;
      return await db.update(
        farmTable,
        farm.toJson(),
        where: 'farm_id = ?',
        whereArgs: [farm.id],
      );
    } catch (_) {
      throw const DbException(message: 'Erro ao atualizar fazenda');
    }
  }
}
