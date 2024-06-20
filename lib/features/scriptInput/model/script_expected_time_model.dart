
class ScriptExpectedTimeModel {

  String? expectedAllTime;
  Map<String?, String?>? expectedTimePerParagraphs;
  Map<String?, String?>? paragraphs;

  ScriptExpectedTimeModel({this.expectedAllTime, this.expectedTimePerParagraphs, this.paragraphs});

  factory ScriptExpectedTimeModel.fromJson(Map<String, dynamic> json) {
    return ScriptExpectedTimeModel(
      expectedAllTime: json["expectedAllTime"],
      expectedTimePerParagraphs: json["expectedTimePerParagraphs"],
      paragraphs: json["paragraphs"]
    );
  }

}

// {
// "expectedAllTime": "00:01:29",
//   "expectedTimePerParagraphs": {
//     "1": "00:01:29",
//     "2": "00:02:29"
//   },
//   "paragraphs": {
//     "1": "qwe",
//     "2": "asd"
//   }
// }