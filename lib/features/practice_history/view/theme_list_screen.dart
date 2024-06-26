import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_list_controller.dart';

class ThemeListScreen extends StatelessWidget {
  const ThemeListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ThemeListCtr>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("발표 기록"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right_rounded),
                Text("발표 주제 목록"),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetX<ThemeListCtr>(
                builder: (_) => ListView.builder(
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
