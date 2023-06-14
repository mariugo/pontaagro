// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_animals_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension FarmAnimalsStatusMatch on FarmAnimalsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == FarmAnimalsStatus.initial) {
      return initial();
    }

    if (v == FarmAnimalsStatus.loading) {
      return loading();
    }

    if (v == FarmAnimalsStatus.success) {
      return success();
    }

    if (v == FarmAnimalsStatus.error) {
      return error();
    }

    throw Exception(
        'FarmAnimalsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == FarmAnimalsStatus.initial && initial != null) {
      return initial();
    }

    if (v == FarmAnimalsStatus.loading && loading != null) {
      return loading();
    }

    if (v == FarmAnimalsStatus.success && success != null) {
      return success();
    }

    if (v == FarmAnimalsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
