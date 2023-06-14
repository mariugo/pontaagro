import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';

void main() {
  final json = {
    'animal_id': 1,
    'animal_farm_id': 1,
    'animal_name': 'Vaca 1',
    'animal_tag': '123456789123456'
  };
  final animalModel = AnimalsModel.fromJson(json);

  group('AnimalModel', () {
    test('should be an instance of AnimalsModel', () {
      expect(animalModel, isA<AnimalsModel>());
    });
    test('should have a animal_id of 1', () {
      expect(animalModel.id, 1);
    });
    test('should have animal_farm_id of 1', () {
      expect(animalModel.farmId, 1);
    });
    test('should have animal_name of Vaca 1', () {
      expect(animalModel.name, 'Vaca 1');
    });
    test('should have animal_tag of 123456789123456', () {
      expect(animalModel.tag, '123456789123456');
    });
    test('should have animal_tag of 15 length', () {
      expect(animalModel.tag.length, 15);
    });
  });
}
