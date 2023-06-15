import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/features/farm_animals/data/models/animals_model.dart';
import 'package:pontaagro/features/farm_animals/domain/usecases/create_animal_list.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/add_animals_state.dart';

class AddAnimalsController extends Cubit<AddAnimalsState> {
  final CreateAnimalsListUseCase createAnimalsListUseCase;
  List<AnimalsModel> animalsList = [];

  AddAnimalsController({
    required this.createAnimalsListUseCase,
  }) : super(const AddAnimalsState.initial());

  void addAnimalToList(AnimalsModel animal) {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      animalsList = [...state.animals];
      animalsList.add(animal);
      emit(state.copyWith(
          status: AddAnimalsStatus.success, animals: animalsList));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error, animals: []));
    }
  }

  void removeAnimalFromList(AnimalsModel animal) {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      animalsList = [...state.animals];
      animalsList.remove(animal);
      emit(state.copyWith(
          status: AddAnimalsStatus.success, animals: state.animals));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error, animals: []));
    }
  }

  Future<void> updateAnimalFromList(AnimalsModel animal) async {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      animalsList = [...state.animals];

      animalsList.removeWhere((element) => element.id == animal.id);
      animalsList.add(animal);
      emit(state.copyWith(
          status: AddAnimalsStatus.success, animals: animalsList));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error, animals: []));
    }
  }

  Future<void> createAnimalsList(List<AnimalsModel> animals) async {
    emit(state.copyWith(status: AddAnimalsStatus.loading));
    try {
      await createAnimalsListUseCase.call(animals);
      state.animals.clear();
      emit(state.copyWith(status: AddAnimalsStatus.success));
    } catch (_) {
      emit(state.copyWith(status: AddAnimalsStatus.error));
    }
  }
}
