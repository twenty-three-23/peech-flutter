import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/history_list_view.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/history_path_view.dart';
import '../controller/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<HistoryCtr>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if(!didPop) {
          controller.backButton(context);

        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () { controller.backButton(context); }, icon: const Icon(Icons.arrow_back_ios)),
          title: const Text("발표 기록"),
        ),
        body: GetX<HistoryCtr>(
          builder: (_) {
            return controller.isLoading == true
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: historyPathView(controller)
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: historyListView(context, controller)
                      ),
                    ),
                  ],
                );
          }
        ),
      ),
    );
  }
}
