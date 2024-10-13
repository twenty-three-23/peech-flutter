import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {

    var historyController = Get.put(HistoryCtr());

    return CommonScaffold(
        appBarTitle: '발표 기록',
        child: Obx( () {
          if (historyController.defaultList.value == null) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
              itemCount: historyController.defaultList.value?.defaultScripts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 166,
                  width: 312,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xffE5E8F0)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xff6D6F78),
                              fontWeight: FontWeight.normal,
                              height: 1.6
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${historyController.defaultList.value?.defaultScripts?[index]}",
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xff3B3E43),
                                fontWeight: FontWeight.normal,
                                height: 1.8
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                          width: 1000,
                          child: OutlinedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12),
                                  ),
                                ),
                                side: MaterialStateProperty.all(
                                  BorderSide(
                                      color: Colors.black, width: 1), // 외곽선 설정
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffF4F6FA)),
                              ),
                              child: Text(
                                "녹음 기록 보기",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: const Color(0xff3B3E43),
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              });
        })
        );
  }
}
