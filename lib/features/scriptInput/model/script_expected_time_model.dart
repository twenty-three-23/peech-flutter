
import 'package:swm_peech_flutter/features/scriptInput/model/expected_time_per_paragraph_model.dart';
import 'package:swm_peech_flutter/features/scriptInput/model/paragraph_model.dart';

class ScriptExpectedTimeModel {

  String? expectedAllTime;
  List<ExpectedTimePerParagraph?>? expectedTimePerParagraphs;
  List<Paragraph?>? paragraphs;

  ScriptExpectedTimeModel({this.expectedAllTime, this.expectedTimePerParagraphs, this.paragraphs});

  factory ScriptExpectedTimeModel.fromJson(Map<String, dynamic> json) {
    return ScriptExpectedTimeModel(
      expectedAllTime: json["expectedAllTime"],
      expectedTimePerParagraphs: (json["expectedTimePerParagraphs"] as List)
        .map((item) => ExpectedTimePerParagraph.fromJson(item))
        .toList(),
      paragraphs: (json["paragraphs"] as List)
        .map((item) => Paragraph.fromJson(item))
        .toList()
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