import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({super.key});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  HistoryCtr controller = Get.find<HistoryCtr>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: const Color(0xffF4F6FA),
      appBarColor: const Color(0xffF4F6FA),
      appBarTitle: '분석 기록',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: GetX<HistoryCtr>(
          builder: (_) => Column(
            children: [
              if (controller.isLoading.value == true)
                Expanded(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Text("분석 기록이에요", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 34 / 22)),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('총 ${controller.practiceResult.value?.totalRealTime ?? "??:??:??"}',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF3B3E43), height: 26 / 18)),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: controller.practiceResult.value?.script?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        if (index == 0)
                          Column(
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  side: const BorderSide(color: Colors.grey),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  controller.aiAnalysisBtn();
                                },
                                child: GetX<HistoryCtr>(
                                  builder: (_) => Column(
                                    children: [
                                      if (controller.aiAnalysisIsShow == false)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'AI의 분석 펼쳐보기',
                                              style: TextStyle(fontWeight: FontWeight.w500),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      if (controller.aiAnalysisIsShow.value == true)
                                        Column(
                                          children: [
                                            SizedBox(height: 6),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'AI의 분석 접기',
                                                  style: TextStyle(fontWeight: FontWeight.w500),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_up,
                                                  size: 16,
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            if (controller.aiAnalysisResult.value == null)
                                              CircularProgressIndicator(
                                                strokeWidth: 1.5,
                                                color: Color(0xff3B3E43),
                                              ),
                                            if (controller.aiAnalysisResult.value != null)
                                              Text(
                                                controller.aiAnalysisResult.value ?? '',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF3B3E43),
                                                ),
                                              ),
                                            SizedBox(height: 16),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white, // 배경 색상
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                          child: Text(
                                            controller.practiceResult.value?.script?[index].time ?? "??:??:??",
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff3B3E43)),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        if (controller.practiceResult.value?.script?[index].measurementResult == '적정')
                                          Container(
                                            decoration: BoxDecoration(color: Color(0xff63BF1C), borderRadius: BorderRadius.circular(8)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                              child: Text(
                                                controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
                                              ),
                                            ),
                                          )
                                        else if (controller.practiceResult.value?.script?[index].measurementResult == '빠름')
                                          Container(
                                            decoration: BoxDecoration(color: Color(0xffFB3149), borderRadius: BorderRadius.circular(8)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                              child: Text(
                                                controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                          )
                                        else if (controller.practiceResult.value?.script?[index].measurementResult == '느림')
                                          Container(
                                            decoration: BoxDecoration(color: Color(0xff2A79FF), borderRadius: BorderRadius.circular(8)),
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                              child: Text(
                                                controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                          )
                                        else
                                          Text(
                                            controller.practiceResult.value?.script?[index].measurementResult ?? "",
                                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          controller.practiceResult.value?.script?[index].paragraph ?? "",
                                          style: const TextStyle(color: Colors.black, fontSize: 16, height: 1.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
