import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';

class FarmBottomSheet extends StatelessWidget {
  final TextEditingController farmNameController;
  final GlobalKey<FormState> formKey;
  final Future<void> Function() onSave;
  final bool? isEdit;

  const FarmBottomSheet({
    required this.farmNameController,
    required this.onSave,
    required this.formKey,
    this.isEdit = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: context.percentHeight(0.25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                isEdit! ? 'Editar Fazenda' : 'Nova Fazenda',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome para a fazenda';
                  }
                  return null;
                },
                controller: farmNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nome da Fazenda',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(context.percentWidth(0.40),
                          context.percentHeight(0.03)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: onSave,
                    child: Text(
                      'Salvar',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(context.percentWidth(0.40),
                          context.percentHeight(0.03)),
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () => context.pop(),
                    child: Text(
                      'Cancelar',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
