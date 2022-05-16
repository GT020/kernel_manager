import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kernel_manager/helper_widgets/consumer_text.dart';
import 'package:kernel_manager/models/cpu_model.dart';
import 'package:kernel_manager/repository/cpu/cpu_repository.dart';
import 'package:kernel_manager/utils/read_utils.dart';

const List<String> coreType = ["Little Core", "Big  Core ", "Prime Core"];

final cpuProvider = FutureProvider<CPU>((ref) async {
  return await CpuRepositoryAndroid().getCPU();
});

class CpuView extends ConsumerWidget {
  const CpuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<CPU> asyncCpu = ref.watch(cpuProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(
                Icons.developer_board_rounded,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'CPU',
              ),
            ],
          ),
        ),
        body: asyncCpu.when(
            data: (cpu) => Wrap(
                  children: [
                    ...coreWidgets(cpu.coreStructure, cpu.cores),
                    Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Name"),
                            Text(cpu.name),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Architecture"),
                            Text(cpu.architecture),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Build Process"),
                            Text(cpu.process),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('Core Count'),
                            Text('${cpu.numberOfCores}'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            error: (error, stack) => Text(error.toString()),
            loading: () => const CircularProgressIndicator()));
  }
}

List<Widget> coreWidgets(List<List<int>> coreStructure, List<CpuCore> cores) {
  List<Widget> list = [];

  for (int count = 0; count < coreStructure.length; count++) {
    list.add(Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              coreType[count],
            ),
            ConsumerStreamText(
              ProviderReadUtil.readIoAsStream(
                  cores[coreStructure[count][0]].currentFrequency),
            ),
          ],
        ),
      ),
    ));
  }
  return list;
}
