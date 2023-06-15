import 'package:pontaagro/features/farms/domain/entities/farms.dart';

class FarmsModel extends Farms {
  const FarmsModel({
    super.id,
    required super.name,
    required super.quantity,
  });

  factory FarmsModel.fromJson(Map<String, dynamic> json) => FarmsModel(
        id: json['farm_id'],
        name: json['farm_name'],
        quantity: json['quantity'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'farm_id': id,
        'farm_name': name,
        'quantity': quantity,
      };
}
