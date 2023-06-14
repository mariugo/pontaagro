import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';

class GetAnimalsUseCase implements UseCase<List<AnimalsModel>, int> {
  final AnimalsRepository repository;

  GetAnimalsUseCase({required this.repository});

  @override
  Future<List<AnimalsModel>> call(int params) async {
    return await repository.getAnimals(params);
  }
}
