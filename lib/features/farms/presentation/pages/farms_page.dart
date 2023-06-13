import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontaagro/features/base_state.dart';
import 'package:pontaagro/features/farms/data/models/farms_model.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_controller.dart';
import 'package:pontaagro/features/farms/presentation/controller/farms_state.dart';
import 'package:pontaagro/features/farms/presentation/widgets/farm_tile.dart';
import 'package:pontaagro/features/farms/presentation/widgets/farm_bottom_sheet.dart';

class FarmsPage extends StatefulWidget {
  const FarmsPage({super.key});

  @override
  State<FarmsPage> createState() => _FarmsPageState();
}

class _FarmsPageState extends BaseState<FarmsPage, FarmsController> {
  final farmName = TextEditingController();
  var editFarmName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final editFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    farmName.dispose();
    editFarmName.dispose();
    formKey.currentState?.dispose();
    editFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.getFarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Ponta >>',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondaryContainer),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<FarmsController, FarmsState>(
          listener: (context, state) {
            state.status.matchAny(
                any: () => hideLoader(),
                loading: () => showLoader(),
                error: () {
                  hideLoader();
                  showError('Erro ao carregar fazendas');
                });
          },
          buildWhen: (previous, current) => current.status.matchAny(
            any: () => false,
            initial: () => true,
            success: () => true,
          ),
          builder: (context, state) {
            return state.status == FarmStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.status == FarmStatus.error
                    ? const Center(
                        child: Text('Erro ao carregar fazendas'),
                      )
                    : state.farms.isEmpty
                        ? Center(
                            child: Text(
                              'Nenhuma fazenda cadastrada',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.farms.length,
                            itemBuilder: (context, index) {
                              return FarmTile(
                                farm: state.farms[index],
                                onEdit: () => showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: FarmBottomSheet(
                                      formKey: editFormKey,
                                      farmNameController: editFarmName =
                                          TextEditingController(
                                              text: state.farms[index].name),
                                      isEdit: true,
                                      onSave: () async {
                                        if (editFormKey.currentState!
                                            .validate()) {
                                          await controller
                                              .updateFarm(FarmsModel(
                                                  name: editFarmName.text,
                                                  id: state.farms[index].id!))
                                              .then((_) {
                                            editFarmName.clear();
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                onDelete: () => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Excluir fazenda'),
                                    content: Text(
                                      'Deseja realmente excluir a fazenda?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Não'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await controller
                                              .deleteFarm(
                                                  state.farms[index].id!)
                                              .then((_) =>
                                                  Navigator.pop(context));
                                        },
                                        child: const Text('Sim'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FarmBottomSheet(
              formKey: formKey,
              farmNameController: farmName,
              onSave: () async {
                if (formKey.currentState!.validate()) {
                  await controller.createFarm(farmName.text).then((_) {
                    farmName.clear();
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ),
        ),
        label: const Text('Fazenda'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
