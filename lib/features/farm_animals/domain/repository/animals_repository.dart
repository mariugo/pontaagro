import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

abstract interface class AnimalsRepository {
  Future<List<AnimalsModel>> getAnimals(int farmId);
  Future<bool> createAnimalList(List<AnimalsModel> animal);
  Future<int> updateAnimal(AnimalsModel animal);
  Future<int> deleteAnimal(int id);
}
