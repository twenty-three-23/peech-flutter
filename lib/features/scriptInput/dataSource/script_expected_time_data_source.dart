


import '../../common/models/expected_time_per_paragraph_model.dart';
import '../../common/models/paragraph_model.dart';
import '../../common/models/script_expected_time_model.dart';

class ScriptExpectedTimeDataSource {


  //테스트용 TODO api요청으로 변경
  Future<ScriptExpectedTimeModel> getExpectedTimeTest() async {

    await Future.delayed(const Duration(seconds: 2));

    return ScriptExpectedTimeModel(
        expectedAllTime: "00:03:42",
        expectedTimePerParagraphs: [
          ExpectedTimePerParagraph(
            paragraphId: 1,
            time: "00:00:10"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 2,
              time: "00:00:35"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 3,
              time: "00:00:21"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 4,
              time: "00:00:23"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 5,
              time: "00:00:34"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 6,
              time: "00:00:22"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 7,
              time: "00:00:19"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 8,
              time: "00:00:21"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 9,
              time: "00:00:18"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 10,
              time: "00:00:20"
          ),
        ],
        paragraphs: [
          Paragraph(
            id: 1,
            paragraph: "안녕하세요? 저는 동물매개팀의 조장 OOO입니다. 반갑습니다."
          ),
          Paragraph(
              id: 2,
              paragraph: "이번에 저희는 동물매개라는 주제를 가지고 활동을 했었는데요. 활동을 하면서 난항을 겪기도 했었고, 많은 어려움들이 있었습니다. 하지만, 우여곡절 끝에 이렇게 발표를 하게되었고, 두가지의 결과물을 가지고 왔습니다. 그럼, 지금부터 발표를 시작하겠습니다."
          ),
          Paragraph(
              id: 3,
              paragraph: "저희 목차인데요. 크게 3가지로 나누었습니다. 제일먼저 활동보고, 두 번째로 활동에 따른 결과발표, 마지막으로 해외컨택을 준비했습니다."
          ),
          Paragraph(
              id: 4,
              paragraph: "첫 번째로 활동보고입니다. 작게 세 개로 나누었는데요. 첫 번째로 활동목적, 두 번째로 방문지 위치 세 번째로 방문지 소개로 준비했습니다."
          ),
          Paragraph(
              id: 5,
              paragraph: "먼저, 강원도입니다. 강원도에서는 1군데만 다녀왔는데요. OO애견트레이닝 센터라고 애견트레이닝에대해 알고자 방문하였습니다. 여기 사진에보이는 분이 OO애견트레이닝센터장인 OOO 대표님이십니다. 다음으로 서울입니다."
          ),
          Paragraph(
              id: 6,
              paragraph: "서울은 총 4군데를 방문하였습니다. OO동물매개치료복지협회, OO독스포츠연맹, OO애견연맥, O펫 총 4군데를 방문하였습니다. 마지막으로 제주도입니다."
          ),
          Paragraph(
              id: 7,
              paragraph: "제주도는 3곳을 방문했는데요. OO이네농장, 마사회 OO조련아카데미, OOO 동물병원 이렇게 다녀왔습니다. 다음으로는 각각 방문지소개를 해드리겠습니다. 그에대한 장단점을 말씀드리겠습니다."
          ),
          Paragraph(
              id: 8,
              paragraph: "얼마전 개업 1주년을 맞이했는데요. 1년밖에되지않은 트레이닝센터의 대표의 연봉이 약 1억 8천만원이라고 합니다. 그래서 개인창업의 성공사례라고 할 수 있습니다."
          ),
          Paragraph(
              id: 9,
              paragraph: "그 이유는 다른 트레이닝센터와 차별성인데요. 트레이닝센터의 90%는 강압적으로 훈련하는반면에, O독을포함한 10%의 트레이닝센터는 긍정강화교육이라는 훈련으로 개들이 스트레스를 받지않고 훈련이 가능하다고 합니다."
          ),
          Paragraph(
              id: 10,
              paragraph: "소음과 냄새의 문제로 시내에서는 불가능합니다. 오히려 이런부분 때문에 시내를 벗어나서 창업을 하게되는데, 땅가격도 저렴해서 장점이라고 할 수 있습니다."
          ),
        ]
    );
  }

}

// {
//   "expectedAllTime": "00:01:29",
//   "expectedTimePerParagraphs": [
//     {
//       "paragraphId": 1,
//       "time": "00:01:29"
//     },
//     {
//       "paragraphId": 2,
//       "time": "00:02:33"
//     }
//   ],
//   "paragraphs": [
//     {
//       "id": 1,
//       "paragraph": "qweqwe"
//     },
//     {
//       "id": 2,
//       "paragraph": "asd"
//     }
//   ]
// }