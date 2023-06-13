import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/features/farms/domain/entities/farms.dart';

void main() {
  const Farms farms = Farms(name: 'Fazenda 1', quantity: 10, id: 1);

  group('Farm Entity', () {
    test('should be an instance of Farms', () {
      expect(farms, isA<Farms>());
    });
    test('should have name as Fazenda 1', () {
      expect(farms.name, 'Fazenda 1');
    });
    test('should have quantity of 10', () {
      expect(farms.quantity, 10);
    });
    test('should have an id of 1', () {
      expect(farms.id, 1);
    });
  });
}
