import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';

class DeleteFarmUseCase implements UseCase<int, int> {
  final FarmsRepository repository;

  const DeleteFarmUseCase({
    required this.repository,
  });

  @override
  Future<int> call(int params) {
    return repository.deleteFarm(params);
  }
}
