import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/core/mixins/loader.dart';
import 'package:pontaagro/core/mixins/snackbar.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, MySnackBar {
  late final C controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
  }
}
