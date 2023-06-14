// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_animals_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension AddAnimalsStatusMatch on AddAnimalsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == AddAnimalsStatus.initial) {
      return initial();
    }

    if (v == AddAnimalsStatus.loading) {
      return loading();
    }

    if (v == AddAnimalsStatus.success) {
      return success();
    }

    if (v == AddAnimalsStatus.error) {
      return error();
    }

    throw Exception('AddAnimalsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == AddAnimalsStatus.initial && initial != null) {
      return initial();
    }

    if (v == AddAnimalsStatus.loading && loading != null) {
      return loading();
    }

    if (v == AddAnimalsStatus.success && success != null) {
      return success();
    }

    if (v == AddAnimalsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
