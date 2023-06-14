import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';

class CreateAnimalsListUseCase implements UseCase<bool, List<AnimalsModel>> {
  final AnimalsRepository repository;

  CreateAnimalsListUseCase({required this.repository});

  @override
  Future<bool> call(List<AnimalsModel> params) async {
    return await repository.createAnimalList(params);
  }
}
