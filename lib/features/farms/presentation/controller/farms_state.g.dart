// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farms_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension FarmStatusMatch on FarmStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == FarmStatus.initial) {
      return initial();
    }

    if (v == FarmStatus.loading) {
      return loading();
    }

    if (v == FarmStatus.success) {
      return success();
    }

    if (v == FarmStatus.error) {
      return error();
    }

    throw Exception('FarmStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == FarmStatus.initial && initial != null) {
      return initial();
    }

    if (v == FarmStatus.loading && loading != null) {
      return loading();
    }

    if (v == FarmStatus.success && success != null) {
      return success();
    }

    if (v == FarmStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
