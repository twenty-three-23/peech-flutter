import 'package:swm_peech_flutter/features/script_input/model/expected_time_by_paragraph_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_by_script_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_model.dart';
import 'package:swm_peech_flutter/features/script_input/model/expected_time_per_paragraph_model.dart';

class MockScriptExpectedTimeDataSource {

  Future<ExpectedTimeModel> getExpectedTimeTest() async {

    await Future.delayed(const Duration(seconds: 2));

    return ExpectedTimeModel(
        expectedTimeByScript: ExpectedTimeByScriptModel(
            hour: 0,
            minute: 3,
            second: 10,
            nano: 2
        ),
        expectedTimeByParagraphs: [
          ExpectedTimeByParagraphModel(
              paragraphId: 1,
              expectedTimePerParagraph: ExpectedTimePerParagraphModel(
                  hour: 0,
                  minute: 0,
                  second: 10,
                  nano: 2
              )
          )
        ]
    );
  }

}