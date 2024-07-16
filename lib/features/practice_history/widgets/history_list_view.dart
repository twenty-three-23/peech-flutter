import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/major_list_view.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/minor_detail_view.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/minor_list_view.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/theme_list_view.dart';

Widget historyListView(BuildContext context, HistoryCtr controller) {
  switch (controller.historyPath.value.pathState.value) {
    case HistoryPathState.themeList:
      return themeListView(controller);
    case HistoryPathState.majorList:
      return majorListView(controller);
    case HistoryPathState.minorList:
      return Column(
        children: [
          TextButton(onPressed: () { controller.majorDetailButton(context); }, child: const Text("기존 대본 보기")),
          Expanded(child: minorListView(controller)),
        ],
      );
    case HistoryPathState.minorDetail:
      return minorDetailView();
  }
}