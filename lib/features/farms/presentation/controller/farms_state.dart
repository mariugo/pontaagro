import 'package:equatable/equatable.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:match/match.dart';

part 'farms_state.g.dart';

@match
enum FarmStatus { initial, loading, success, error }

class FarmsState extends Equatable {
  final FarmStatus status;
  final List<FarmsModel> farms;

  const FarmsState({
    required this.status,
    required this.farms,
  });

  const FarmsState.initial()
      : status = FarmStatus.initial,
        farms = const [];

  FarmsState copyWith({
    FarmStatus? status,
    List<FarmsModel>? farms,
  }) {
    return FarmsState(
      status: status ?? this.status,
      farms: farms ?? this.farms,
    );
  }

  @override
  List<Object> get props => [status, farms];
}
