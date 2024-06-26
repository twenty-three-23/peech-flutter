import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/major_list_view.dart';
import '../controller/history_controller.dart';
import '../widgets/theme_list_view.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<HistoryCtr>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("발표 기록"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right_rounded),
                Text("발표 주제 목록"),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetX<HistoryCtr>(
                builder: (_) {
                  switch(controller.historyPath.value.pathState.value) {
                    case HistoryPathState.themeList:
                      return themeListView(controller);
                    case HistoryPathState.majorList:
                      return majorListView(controller);
                    case HistoryPathState.minorList:
                      return const Text("minorList");
                    case HistoryPathState.minorDetail:
                      return const Text("minorDetail");
                  }
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
