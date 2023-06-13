import 'package:flutter/material.dart';

mixin MySnackBar<T extends StatefulWidget> on State<T> {
  void showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        padding: EdgeInsets.all(20),
        elevation: 3,
        content: Text('Fazenda adicionada com sucesso'),
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        padding: const EdgeInsets.all(20),
        elevation: 3,
        backgroundColor: Theme.of(context).colorScheme.error,
        content: const Text('Erro ao cadastrar fazenda'),
      ),
    );
  }
}
