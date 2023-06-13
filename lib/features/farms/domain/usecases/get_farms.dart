import 'package:pontaagro/core/usecase/usecase.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/repository/farms_repository.dart';

class GetFarmsUseCase implements UseCase<List<FarmsModel>, void> {
  final FarmsRepository repository;

  const GetFarmsUseCase({
    required this.repository,
  });

  @override
  Future<List<FarmsModel>> call(void params) {
    return repository.getFarms();
  }
}
