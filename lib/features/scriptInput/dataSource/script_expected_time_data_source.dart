import '../model/script_expected_time_model.dart';

class ScriptExpectedTimeDataSource {

  Future<ScriptExpectedTimeModel> getExpectedTimeTest() async {

    await Future.delayed(const Duration(seconds: 2));

    return ScriptExpectedTimeModel(
      expectedAllTime: "00:01:29",
      expectedTimePerParagraphs: {
        "1": "00:01:29",
        "2": "00:02:29"
      },
      paragraphs: {
        "1": "qwe",
        "2": "asd"
      }
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
//
//   }
// }