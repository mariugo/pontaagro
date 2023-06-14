import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farm_animals/domain/repository/animals_repository.dart';

class DeleteAnimalUseCase implements UseCase<int, int> {
  final AnimalsRepository repository;

  DeleteAnimalUseCase({required this.repository});

  @override
  Future<int> call(int params) async {
    return await repository.deleteAnimal(params);
  }
}
