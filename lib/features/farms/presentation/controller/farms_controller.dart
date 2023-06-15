import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/domain/usecases/create_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/delete_farm.dart';
import 'package:pontaagro/features/farms/domain/usecases/get_farms.dart';
import 'package:pontaagro/features/farms/domain/usecases/update_farm.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_state.dart';

class FarmsController extends Cubit<FarmsState> {
  final GetFarmsUseCase getFarmsUseCase;
  final CreateFarmUseCase createFarmUseCase;
  final DeleteFarmUseCase deleteFarmUseCase;
  final UpdateFarmUseCase updateFarmUseCase;

  FarmsController(this.createFarmUseCase, this.deleteFarmUseCase,
      this.getFarmsUseCase, this.updateFarmUseCase)
      : super(const FarmsState.initial());

  Future<void> getFarms() async {
    emit(state.copyWith(status: FarmStatus.loading));
    try {
      final farms = await getFarmsUseCase.call(null);
      emit(state.copyWith(status: FarmStatus.success, farms: farms));
    } catch (_) {
      emit(state.copyWith(status: FarmStatus.error, farms: []));
    }
  }

  Future<void> createFarm(String name) async {
    emit(state.copyWith(status: FarmStatus.loading));
    try {
      await createFarmUseCase.call(FarmsModel(name: name, quantity: 0));
      await getFarms();
      emit(state.copyWith(status: FarmStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FarmStatus.error));
    }
  }

  Future<void> deleteFarm(int id) async {
    emit(state.copyWith(status: FarmStatus.loading));
    try {
      await deleteFarmUseCase.call(id);
      await getFarms();
      emit(state.copyWith(status: FarmStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FarmStatus.error));
    }
  }

  Future<void> updateFarm(FarmsModel farm) async {
    emit(state.copyWith(status: FarmStatus.loading));
    try {
      await updateFarmUseCase.call(farm);
      await getFarms();
      emit(state.copyWith(status: FarmStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FarmStatus.error));
    }
  }

  Future<void> updateQuantity(int num, FarmsModel farm) async {
    print('=========== UPDATE QUANTITY =======OLDFARM============== $farm');
    var newFarm = FarmsModel(name: farm.name, quantity: num, id: farm.id);
    print('=========== UPDATE QUANTITY =======NEWFARM============== $newFarm');
    try {
      await updateFarm(newFarm);
      emit(state.copyWith(status: FarmStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FarmStatus.error));
    }
  }
}
