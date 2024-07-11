import 'package:swm_peech_flutter/features/script_input/model/expected_time_by_paragraph_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';

class MockScriptExpectedTimeDataSource {

  Future<ExpectedTimeModel> getExpectedTimeTest() async {

    await Future.delayed(const Duration(seconds: 2));

    return ExpectedTimeModel(
        expectedTimeByScript: "00:05:10.2",
        expectedTimeByParagraphs: [
          ExpectedTimeByParagraphModel(
              paragraphId: 1,
              expectedTimePerParagraph: "00:00:10.2"
          )
        ]
    );
  }

}