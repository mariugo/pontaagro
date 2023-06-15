import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOpen = true;

  void showLoader() {
    if (isOpen) {
      isOpen = false;
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
    }
  }

  void hideLoader() {
    if (!isOpen) {
      isOpen = true;
      context.pop();
    }
  }
}
