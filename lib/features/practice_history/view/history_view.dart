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
      appBarTitle: '자기소개 녹음 기록',
      hideBackButton: true,
      child: Obx(
        () {
          if (historyController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (historyController.defaultList.value?.defaultScripts == null) {
            return Center(child: Text("데이터가 없습니다."));
          }
          return ListView.builder(
              itemCount: historyController.defaultList.value?.defaultScripts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                DateTime utcTime = DateTime.utc(
                    historyController.defaultList.value?.defaultScripts?[index].createdAt?.year ?? 1990,
                    historyController.defaultList.value?.defaultScripts?[index].createdAt?.month ?? 1,
                    historyController.defaultList.value?.defaultScripts?[index].createdAt?.day ?? 1,
                    historyController.defaultList.value?.defaultScripts?[index].createdAt?.hour ?? 1,
                    historyController.defaultList.value?.defaultScripts?[index].createdAt?.minute ?? 0,
                    historyController.defaultList.value?.defaultScripts?[index].createdAt?.second ?? 0); // 예시 UTC 시간
                DateTime koreaTime = utcTime.toLocal();
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
                            "${koreaTime.year}.${koreaTime.month}.${koreaTime.day} ${historyController.weekday[koreaTime.weekday]} ${(koreaTime.hour ?? 0) < 12 ? '오전' : '오후'} ${(koreaTime.hour ?? 0) % 12}:${koreaTime.minute}",
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color(0xff6D6F78),
                              fontWeight: FontWeight.w600,
                              height: 16 / 12,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${historyController.defaultList.value?.defaultScripts?[index].scriptContent}",
                              style: TextStyle(
                                fontSize: 12,
                                color: const Color(0xff3B3E43),
                                fontWeight: FontWeight.w400,
                                height: 18 / 12,
                              ),
                              overflow: TextOverflow.ellipsis, // 남는 텍스트는 생략 표시
                              maxLines: 3, // 표시할 수 있는 최대 줄 수
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    historyController.gotoDetailBtn(context, historyController.defaultList.value?.defaultScripts?[index].scriptId ?? 0);
                                  },
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
                                      height: 18 / 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {
                                      historyController.gotoInterviewQuestion(context, index);
                                    },
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
                                      "예상 질문 받기",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: const Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.w600,
                                        height: 18 / 14,
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
        },
      ),
    );
  }
}
