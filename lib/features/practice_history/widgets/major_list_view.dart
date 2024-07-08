import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

Widget majorListView(HistoryCtr controller) {
  return GridView.builder(
    key: const PageStorageKey("majorListView"),
    controller: controller.majorScrollController,
    itemCount: controller.majorList.value?.majorScripts?.length ?? 0,
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 2/3,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () { controller.clickMajorList(index); },
          child: Column(
            children: [
              Container(
                height: 200,
                width: 170,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    controller.majorList.value?.majorScripts?[index].scriptContent ?? "unknown",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                    maxLines: 13,

                  ),
                ),
              ),
              Text(
                controller.majorList.value?.majorScripts?[index].createdAt ?? "unknown",
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}