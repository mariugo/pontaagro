import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/delete_animal.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/get_animals_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_state.dart';

class FarmAnimalsController extends Cubit<FarmAnimalsState> {
  final GetAnimalsListUseCase getAnimalsListUseCase;
  final DeleteAnimalUseCase deleteAnimalUseCase;

  FarmAnimalsController(this.getAnimalsListUseCase, this.deleteAnimalUseCase)
      : super(const FarmAnimalsState.initial());

  Future<void> getAnimalList(int farmId) async {
    emit(state.copyWith(status: FarmAnimalsStatus.loading));
    try {
      final animals = await getAnimalsListUseCase.call(farmId);
      emit(state.copyWith(status: FarmAnimalsStatus.success, animals: animals));
    } catch (e) {
      emit(state.copyWith(status: FarmAnimalsStatus.error, animals: []));
    }
  }

  Future<void> deleteAnimal(int animalId) async {
    emit(state.copyWith(status: FarmAnimalsStatus.loading));
    try {
      await deleteAnimalUseCase.call(animalId);
      await getAnimalList(state.animals.first.farmId);
      emit(state.copyWith(status: FarmAnimalsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FarmAnimalsStatus.error));
    }
  }
}
