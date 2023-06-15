import 'package:flutter_test/flutter_test.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';

void main() {
  final json = {'farm_id': 1, 'farm_name': 'Fazenda 1', 'quantity': 10};
  const farmModel = FarmsModel(id: 1, name: 'Fazenda 1', quantity: 10);
  final farmsModel = FarmsModel.fromJson(json);
  farmModel.toJson();

  group('FarmsModelFromJson', () {
    test('should be an instance of FarmsModel', () {
      expect(farmsModel, isA<FarmsModel>());
    });
    test('should have a farm_id of 1', () {
      expect(farmsModel.id, 1);
    });
    test('should have Fazenda 1 as farm_name', () {
      expect(farmsModel.name, 'Fazenda 1');
    });
    test('should have quantity of 10', () {
      expect(farmsModel.quantity, 10);
    });
  });

  group('FarmsModelToJson', () {
    test('should be an instance of FarmsModel', () {
      expect(farmModel, isA<FarmsModel>());
    });
    test('should have a farm_id of 1', () {
      expect(farmModel.id, 1);
    });
    test('should have Fazenda 1 as farm_name', () {
      expect(farmModel.name, 'Fazenda 1');
    });
    test('should have quantity of 10', () {
      expect(farmModel.quantity, 10);
    });
  });
}
