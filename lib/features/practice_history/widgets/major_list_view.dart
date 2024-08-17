import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

Widget majorListView(HistoryCtr controller) {
  return CustomScrollView(
    key: const PageStorageKey("majorListView"),
    controller: controller.majorScrollController,
    slivers: [
      SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "주제: ${controller.themeList.value?.themes?.firstWhere((element) => element.themeId == controller.historyPath.value.theme).themeTitle ?? "unknown"}",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3B3E43),
                          height: 34 / 22
                      )
                  ),
                  const SizedBox(height: 8,),
                  const Text(
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  controller.clickMajorList(index);
                },
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
                          controller.majorList.value?.majorScripts?[index]
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
                      controller.majorList.value?.majorScripts?[index]
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
          controller.majorList.value?.majorScripts?.length ?? 0,
        ),
      ),
    ],
  );
}