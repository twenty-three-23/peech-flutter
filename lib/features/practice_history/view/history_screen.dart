import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                builder: (_) => themeListView(controller)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
