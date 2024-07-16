import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';
import 'package:swm_peech_flutter/features/practice_history/model/history_major_model.dart';

class HistoryMajorDetailScreen extends StatelessWidget {
  const HistoryMajorDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    HistoryCtr controller = Get.find<HistoryCtr>();
    HistoryMajorModel? major = controller.majorList.value?.majorScripts?.firstWhereOrNull((element) => element.majorVersion == controller.historyPath.value.major);
    print("major: ${controller.historyPath.value.major}");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.pop(context); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("발표 기록"),
      ),
      body:
      GetX<HistoryCtr>(
          builder: (_) => SizedBox(
            child: controller.majorDetail.value == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("날짜: ${major?.createdAt ?? "unknown"}")
                      ),
                      const SizedBox(height: 10,),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.majorDetail.value?.paragraphs?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.majorDetail.value?.paragraphs?[index].paragraphContent ?? '이 정보를 불러올 수 없습니다.',
                                  style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      )
                    ],
                  ),
                ),
              ),
          ),
        ),
    );
  }
}
