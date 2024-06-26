import 'package:flutter/material.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

Widget themeListView(HistoryCtr controller) {
  return ListView.builder(
      itemCount: controller.themeList.value?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Icon(Icons.file_copy),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        maxLines: 1,
                        controller.themeList.value?[index].title ?? "unknown",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Text(
                      controller.themeList.value?[index].timestamp ?? "unknown",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("${controller.themeList.value?[index].count ?? "unknown"}개"),
                )
              ],
            ),
            const Divider(height: 1,)
          ],
        );
      }
  );
}