import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/common/widgets/primary_color_button.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_model.dart';

class HistoryMajorDetailScreen extends StatelessWidget {
  const HistoryMajorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    HistoryCtr controller = Get.find<HistoryCtr>();
    HistoryMajorModel? major = controller.majorList.value?.majorScripts?.firstWhereOrNull((element) => element.majorVersion == controller.historyPath.value.major);
    print("major: ${controller.historyPath.value.major}");

    return CommonScaffold(
      appBarTitle: '발표 기록',
      child:
      GetX<HistoryCtr>(
          builder: (_) => SizedBox(
            child: controller.majorDetail.value == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView(
                      children: [
                        const SizedBox(height: 10,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("날짜: ${major?.createdAt ?? "unknown"}")
                        ),
                        const SizedBox(height: 10,),
                        for(int i = 0; i < (controller.majorDetail.value?.paragraphs?.length ?? 0); i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.majorDetail.value?.paragraphs?[i].paragraphContent ?? '이 정보를 불러올 수 없습니다.',
                                  style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ]
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ColoredButton(
                          text: '이 대본으로 시작하기',
                          onPressed: () {
                            controller.startWithMajorScriptBtn(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
              ],
            ),
          ),
        ),
    );
  }
}
