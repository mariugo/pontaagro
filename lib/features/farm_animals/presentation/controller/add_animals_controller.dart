import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_state.dart';

class AddAnimalsController extends Cubit<AddAnimalsState> {
  final CreateAnimalsListUseCase createAnimalsListUseCase;

  AddAnimalsController(
    this.createAnimalsListUseCase,
  ) : super(const AddAnimalsState.initial());

  void addAnimalToList(AnimalsModel animal) {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      state.animals.add(animal);
      emit(state.copyWith(
          status: AddAnimalsStatus.success, animals: state.animals));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error, animals: []));
    }
  }

  void removeAnimalFromList(AnimalsModel animal) {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      state.animals.remove(animal);
      emit(state.copyWith(
          status: AddAnimalsStatus.success, animals: state.animals));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error, animals: []));
    }
  }

  void updateAnimalFromList(AnimalsModel animal) {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      state.animals.removeWhere((element) => element.id == animal.id);
      state.animals.add(animal);
      emit(state.copyWith(
          status: AddAnimalsStatus.success, animals: state.animals));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error, animals: []));
    }
  }

  Future<void> createAnimalsList() async {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      await createAnimalsListUseCase(state.animals);
      emit(state.copyWith(status: AddAnimalsStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error));
    }
  }
}
