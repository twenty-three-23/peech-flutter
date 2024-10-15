import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:swm_peech_flutter/features/common/widgets/common_scaffold.dart';
import 'package:swm_peech_flutter/features/practice_history/controller/history_controller.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  late HistoryCtr historyController = Get.find<HistoryCtr>();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        appBarTitle: '발표 기록',
        child: Obx(() {
          if (historyController.defaultList.value?.defaultScripts == null) {
            return Center(child: Text("데이터가 없습니다."));
          } else if (historyController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: historyController.defaultList.value?.defaultScripts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                  child: Container(
                    height: 166,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xffE5E8F0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${historyController.defaultList.value?.defaultScripts?[index].createdAt}",
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xff6D6F78),
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${historyController.defaultList.value?.defaultScripts?[index].scriptContent}",
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xff3B3E43),
                                fontWeight: FontWeight.w400,
                                height: 1.8,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      side: MaterialStateProperty.all(
                                        BorderSide(color: Colors.black, width: 1), // 외곽선 설정
                                      ),
                                      backgroundColor: MaterialStateProperty.all(const Color(0xffF4F6FA)),
                                    ),
                                    child: Text(
                                      "분석 보기",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: const Color(0xff3B3E43),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      side: MaterialStateProperty.all(
                                        BorderSide(color: Color(0xFF3B3E43), width: 1), // 외곽선 설정
                                      ),
                                      backgroundColor: MaterialStateProperty.all(const Color(0xFF3B3E43)),
                                    ),
                                    child: Text(
                                      "예상 면접질문 받아보기",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }));
  }
}
