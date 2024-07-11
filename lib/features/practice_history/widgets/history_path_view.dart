import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_path_model.dart';
import 'package:swm_peech_flutter/features/practice_history/widgets/history_path_unit.dart';

Widget historyPathView(HistoryCtr controller) {

  return GetX<HistoryCtr>(
    builder: (_) => SingleChildScrollView(
      controller: controller.pathScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          historyPathUnit(
              text: "발표 주제 목록",
              onClick: () { controller.historyPath.value.setPrevPath(HistoryPathState.themeList); }
          ),
          if(controller.historyPath.value.theme != null)
            historyPathUnit(
                text: controller.themeList.value?.themes?.firstWhereOrNull((element) => element.themeId == controller.historyPath.value.theme)?.themeTitle.toString() ?? 'unknown',
                onClick: () { controller.historyPath.value.setPrevPath(HistoryPathState.majorList); }
            ),
          if(controller.historyPath.value.major != null)
            historyPathUnit(
                text: controller.majorList.value?.majorScripts?.firstWhereOrNull((element) => element.majorVersion == controller.historyPath.value.major)?.createdAt.toString() ?? 'unknown',
                onClick: () { controller.historyPath.value.setPrevPath(HistoryPathState.minorList); }
            ),
          if(controller.historyPath.value.minor != null)
            historyPathUnit(
                text: controller.minorList.value?.minorScripts?.firstWhereOrNull((element) => element.minorVersion == controller.historyPath.value.minor)?.createdAt.toString() ?? 'unknown',
                onClick: () {  }
            ),
        ],
      ),
    ),
  );
}