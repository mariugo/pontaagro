import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';

class UpdateFarmUseCase implements UseCase<int, FarmsModel> {
  final FarmsRepository repository;

  const UpdateFarmUseCase({
    required this.repository,
  });

  @override
  Future<int> call(FarmsModel params) {
    return repository.updateFarm(params);
  }
}
