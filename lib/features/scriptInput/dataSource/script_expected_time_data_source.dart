
import 'package:swm_peech_flutter/features/scriptInput/model/expected_time_per_paragraph_model.dart';

import '../model/paragraph_model.dart';
import '../model/script_expected_time_model.dart';

class ScriptExpectedTimeDataSource {


  //테스트용 TODO api요청으로 변경
  Future<ScriptExpectedTimeModel> getExpectedTimeTest() async {

    await Future.delayed(const Duration(seconds: 2));

    return ScriptExpectedTimeModel(
        expectedAllTime: "00:01:29",
        expectedTimePerParagraphs: [
          ExpectedTimePerParagraph(
            paragraphId: 1,
            time: "00:01:29"
          ),
          ExpectedTimePerParagraph(
              paragraphId: 1,
              time: "00:02:33"
          ),
        ],
        paragraphs: [
          Paragraph(
            id: 1,
            paragraph: "qweqwe"
          ),
          Paragraph(
              id: 1,
              paragraph: "asd"
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
//       "paragraphId": 1,
//       "time": "00:02:33"
//     }
//   ],
//   "paragraphs": [
//     {
//       "id": 1,
//       "paragraph": "qweqwe"
//     },
//     {
//       "id": 1,
//       "paragraph": "asd"
//     }
//   ]
// }