import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';

class UpdateAnimalUseCase implements UseCase<int, AnimalsModel> {
  final AnimalsRepository repository;

  UpdateAnimalUseCase({required this.repository});

  @override
  Future<int> call(AnimalsModel params) async {
    return await repository.updateAnimal(params);
  }
}
