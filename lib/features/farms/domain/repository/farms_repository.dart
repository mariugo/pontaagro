import 'package:pontaagro/features/farms/data/models/farms_model.dart';

abstract interface class FarmsRepository {
  Future<int> createFarm(FarmsModel farm);
  Future<List<FarmsModel>> getFarms();
  Future<int> updateFarm(FarmsModel farm);
  Future<int> deleteFarm(int id);
}
