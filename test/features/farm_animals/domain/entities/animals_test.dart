import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/features/farm_animals/domain/entities/animals.dart';

void main() {
  const Animals animal = Animals(
    farmId: 1,
    name: 'Vaca',
    tag: '123456789123456',
    id: 1,
  );

  group('Animal Entity', () {
    test('should be an instance of Animals', () {
      expect(animal, isA<Animals>());
    });
    test('should have name as Vaca', () {
      expect(animal.name, 'Vaca');
    });
    test('should have an id of 1', () {
      expect(animal.id, 1);
    });
    test('should have a farm_id of 1', () {
      expect(animal.farmId, 1);
    });
    test('should have a tag of 123456789123456', () {
      expect(animal.tag, '123456789123456');
    });
    test('should have a tag of 15 length', () {
      expect(animal.tag.length, 15);
    });
  });
}
