import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/common/data_source/local/local_practice_mode_storage.dart';
import 'package:swm_peech_flutter/features/common/widgets/colored_button.dart';
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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: majorListView(controller)),
          Row(
            children: [
              Expanded(
                child: ColoredButton(
                  text: '이 주제로 시작하기',
                  onPressed: () {
                    controller.startWithThemeWithScriptBtn(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () {
                      controller.startWithThemeNoScriptBtn(context);
                    },
                    child: const Text("이 주제로 대본없이 녹음 바로 하기",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3B3E43),
                          height: 22 / 14,
                        ))),
              ),
            ],
          ),
        ],
      );
    case HistoryPathState.minorList:
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: minorListView(controller)),
          Row(
            children: [
              Expanded(
                child: ColoredButton(
                  text: '선택한 대본 상세보기',
                  onPressed: () {
                    controller.majorDetailButton(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      );
    case HistoryPathState.minorDetail:
      return Column(
        children: [
          Expanded(child: minorDetailView(controller)),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: ColoredButton(
                  text: '이 대본으로 시작하기',
                  onPressed: () {
                    controller.startWithThemeWithScriptBtn(context);
                  },
                ),
              ),
            ],
          ),
        ],
      );
  }
}
