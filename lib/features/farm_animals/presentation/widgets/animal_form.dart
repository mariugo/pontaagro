import 'package:flutter/material.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';

class AnimalForm extends StatelessWidget {
  final GlobalKey formKey;
  final TextEditingController animalNameController;
  final TextEditingController tagController;
  final Future<void> Function() onSave;
  final bool canCancel;

  const AnimalForm({
    required this.formKey,
    required this.animalNameController,
    required this.tagController,
    required this.onSave,
    required this.canCancel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome para o animal';
              }
              return null;
            },
            controller: animalNameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nome',
            ),
          ),
          SizedBox(
            height: context.percentHeight(0.02),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            maxLength: 15,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome para o animal';
              } else if (value.length != 15) {
                return 'Tag deve conter 15 dígitos';
              }
              return null;
            },
            controller: tagController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tag do animal',
            ),
          ),
          SizedBox(
            height: context.percentHeight(0.02),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                      context.percentWidth(0.40), context.percentHeight(0.03)),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: onSave,
                child: Text(
                  canCancel ? 'Inserir' : 'Atualizar',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Visibility(
                visible: canCancel,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(context.percentWidth(0.40),
                        context.percentHeight(0.03)),
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    animalNameController.clear();
                    tagController.clear();
                  },
                  child: Text(
                    'Cancelar',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
