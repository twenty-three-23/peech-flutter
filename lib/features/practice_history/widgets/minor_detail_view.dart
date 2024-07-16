import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

Widget minorDetailView(HistoryCtr controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: GetX<HistoryCtr>(
        builder: (_) => SizedBox(
          child: controller.minorDetail.value == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: controller.minorDetail.value?.paragraphDetails?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${controller.minorDetail.value?.paragraphDetails?[index].realTimePerParagraph}",
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold
                            ),
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
                          child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    height: 1.4
                                ),
                                children: [
                                  for(int j = 0; j < (controller.minorDetail.value?.paragraphDetails?.length ?? 0); j++)
                                    TextSpan(
                                        text: "${controller.minorDetail.value?.paragraphDetails?[index].sentences?[j]} ",
                                    )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        )
    ),
  );

}