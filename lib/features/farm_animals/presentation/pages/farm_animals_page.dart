import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/core/extensions/size_extensions.dart';
import 'package:pontaagro/features/base_state.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_controller.dart';
import 'package:pontaagro/features/farm_animals/presentation/controller/farm_animals_state.dart';
import 'package:pontaagro/features/farm_animals/presentation/widgets/animal_tile.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';

class FarmAnimalsPage extends StatefulWidget {
  final FarmsModel farm;

  const FarmAnimalsPage({
    required this.farm,
    super.key,
  });

  @override
  State<FarmAnimalsPage> createState() => _FarmAnimalsPageState();
}

class _FarmAnimalsPageState
    extends BaseState<FarmAnimalsPage, FarmAnimalsController> {
  // final animals = [
  //   const AnimalsModel(
  //     name: 'Vaca',
  //     tag: '123456789',
  //     farmId: 1,
  //   ),
  //   const AnimalsModel(
  //     name: 'Vaca',
  //     tag: '123456789',
  //     farmId: 1,
  //   ),
  //   const AnimalsModel(
  //     name: 'Vaca',
  //     tag: '123456789',
  //     farmId: 1,
  //   ),
  //   const AnimalsModel(
  //     name: 'Vaca',
  //     tag: '123456789',
  //     farmId: 1,
  //   ),
  //   const AnimalsModel(
  //     name: 'Vaca',
  //     tag: '123456789',
  //     farmId: 1,
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          '${widget.farm.name} >> Animais ',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<FarmAnimalsController, FarmAnimalsState>(
          listener: (context, state) {
            state.status.matchAny(
                any: () => hideLoader(),
                loading: () => showLoader(),
                error: () {
                  hideLoader();
                  showError('Erro ao carregar animais');
                });
          },
          buildWhen: (previous, current) => current.status.matchAny(
                any: () => false,
                initial: () => true,
                success: () => true,
              ),
          builder: (context, state) {
            return state.status == FarmAnimalsStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.status == FarmAnimalsStatus.error
                    ? const Center(
                        child: Text(
                          'Erro ao carregar animais',
                        ),
                      )
                    : state.animals.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhum animal cadastrado',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              itemCount: state.animals.length,
                              itemBuilder: (context, index) {
                                return AnimalTile(
                                  canEdit: false,
                                  animal: state.animals[index],
                                  onDelete: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Excluir animal'),
                                      content: Text(
                                        'Deseja realmente excluir o animal?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Não',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.percentWidth(0.010),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await controller
                                                .deleteAnimal(
                                                    state.animals[index].id!)
                                                .then((_) =>
                                                    Navigator.pop(context));
                                          },
                                          child: Text(
                                            'Sim',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .error,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Animal'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
