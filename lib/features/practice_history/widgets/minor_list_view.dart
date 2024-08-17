import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

Widget minorListView(HistoryCtr controller) {
  return CustomScrollView(
    key: const PageStorageKey("minorListView"),
    controller: controller.minorScrollController,
    slivers: [
      const SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "선택한 대본의 연습 기록",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3B3E43),
                          height: 34 / 22
                      )
                  ),
                  SizedBox(height: 8,),
                  Text(
                      "대본을 클릭하여 상세정보를 확인할 수 있습니다",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF3B3E43),
                          height: 22 / 14
                      )
                  ),
                ],
              ),
            ),
          ],
        )
      ),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 3,
        ),
        delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                controller.clickMinorList(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 170,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.minorList.value?.minorScripts?[index]
                              .scriptContent ??
                              "unknown",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                          maxLines: 13,
                        ),
                      ),
                    ),
                    Text(
                      controller.minorList.value?.minorScripts?[index]
                          .createdAt ??
                          "unknown",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
          childCount:
          controller.minorList.value?.minorScripts?.length ?? 0,
        ),
      ),
    ],
  );
}