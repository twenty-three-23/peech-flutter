import 'package:swm_peech_flutter/features/practice_result/model/now_status.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_list_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/paragraph_model.dart';
import 'package:swm_peech_flutter/features/practice_result/model/sentence_model.dart';

class MockPracticeResultDataSource {

  Future<ParagraphListModel> getPracticeResultListTest() async {
    await Future.delayed(const Duration(seconds: 3));
    return ParagraphListModel(
      script: [
        ParagraphModel(
          paragraphId: 1,
          paragraphOrder: 1,
          time: "00:00:00",
          nowStatus: NowStatus.realTime,
          sentences: [
            SentenceModel(
              sentenceId: '1',
              sentenceOrder: 1,
              sentenceContent: "어린이 여러분 안녕하세요."
            ),
            SentenceModel(
                sentenceId: '2',
                sentenceOrder: 2,
                sentenceContent: "우리 친구들은 안 좋은 습관이 있나요?"
            ),
            SentenceModel(
                sentenceId: '3',
                sentenceOrder: 3,
                sentenceContent: "손가락을 계속 빤다거나 콧구멍을 계속 후빈다거나 그래서 엄마한테 꾸지람을 듣기도 하지만 참 고쳐지지 않는 습관이죠."
            ),
            SentenceModel(
                sentenceId: '4',
                sentenceOrder: 4,
                sentenceContent: "그런데 그렇게 계속 안 좋은 습관을 갖게 되면 무시무시한 일이 일어난대요."
            ),
            SentenceModel(
                sentenceId: '5',
                sentenceOrder: 5,
                sentenceContent: "과연 무슨 일이 일어날지?"
            ),
            SentenceModel(
                sentenceId: '6',
                sentenceOrder: 6,
                sentenceContent: "그럼 신나는 동화 여행 속에서 그 비밀을 알아볼까요?"
            ),
            SentenceModel(
                sentenceId: '7',
                sentenceOrder: 7,
                sentenceContent: "콧구멍을 후비면 이렇게 되면 참 좋겠다."
            ),
            SentenceModel(
                sentenceId: "8",
                sentenceOrder: 8,
                sentenceContent: "콧구멍을 후비면 다이아몬드가 쑥 나오고, 깃벌을 자꾸 만지면 날개처럼 커져서 하늘을 날 수 있으면 좋겠어."
            ),
          ]
        ),
        ParagraphModel(
            paragraphId: 1,
            paragraphOrder: 1,
            time: "00:00:00",
            nowStatus: NowStatus.realTime,
            sentences: [
              SentenceModel(
                  sentenceId: "1",
                  sentenceOrder: 1,
                  sentenceContent: "sentence content"
              )
            ]
        ),
        ParagraphModel(
            paragraphId: 1,
            paragraphOrder: 1,
            time: "00:00:00",
            nowStatus: NowStatus.realTime,
            sentences: [
              SentenceModel(
                  sentenceId: "1",
                  sentenceOrder: 1,
                  sentenceContent: "sentence content"
              )
            ]
        ),
        ParagraphModel(
            paragraphId: 1,
            paragraphOrder: 1,
            time: "00:00:00",
            nowStatus: NowStatus.realTime,
            sentences: [
              SentenceModel(
                  sentenceId: "1",
                  sentenceOrder: 1,
                  sentenceContent: "sentence content"
              )
            ]
        ),
        ParagraphModel(
            paragraphId: 1,
            paragraphOrder: 1,
            time: "00:00:00",
            nowStatus: NowStatus.realTime,
            sentences: [
              SentenceModel(
                  sentenceId: "1",
                  sentenceOrder: 1,
                  sentenceContent: "sentence content"
              )
            ]
        ),
      ]
    );
  }
}