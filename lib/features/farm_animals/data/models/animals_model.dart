import 'package:pontaagro/features/farm_animals/domain/entities/animals.dart';

class AnimalsModel extends Animals {
  const AnimalsModel({
    super.id,
    required super.farmId,
    required super.name,
    required super.tag,
  });

  factory AnimalsModel.fromJson(Map<String, dynamic> json) => AnimalsModel(
        id: json['animal_id'],
        farmId: json['animal_farm_id'],
        name: json['animal_name'],
        tag: json['animal_tag'],
      );

  Map<String, dynamic> toJson() => {
        'animal_id': id,
        'animal_farm_id': farmId,
        'animal_name': name,
        'animal_tag': tag,
      };
}
