import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewModel/script_input_controller.dart';

class ScriptInputScreen extends StatelessWidget {
  const ScriptInputScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ScriptInputController _controller = Get.put(ScriptInputController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () { Navigator.of(context).pop(); }, icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("대본으로 시작"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text("대본을 입력해주세요"),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GetX<ScriptInputController>(
                  builder: (_) => TextField(
                    minLines: 1,
                    maxLines: null,
                    onChanged: (value) {
                      _controller.updateScript(value);
                    },
                    decoration: InputDecoration(
                        hintText: "안녕하세요. 발표 시작하겠습니다...",
                        border: const OutlineInputBorder(),
                        counterText: "${_controller.script.value?.length ?? 0} 자"
                    ),
                  ),
                )
              ),
            ),
            TextButton(
                child: const Text("예상 시간 확인"),
                onPressed: () {
                  // viewModel.getExpectedTimeTest();
                  // showDialog(
                  //     context: context,
                  //     builder: ((context) {
                  //       return AlertDialog(
                  //         title: const Text("예상 시간입니다"),
                  //         content: Text(viewModelState.scriptExpectedTimeModel == null ? "로딩중" : "결과"),
                  //         actions: [
                  //           ElevatedButton(
                  //               onPressed: () { Navigator.of(context).pop(); },
                  //               child: const Text("닫기")
                  //           )
                  //         ],
                  //       );
                  //     })
                  // );
                },
            ),
          ],
        ),
      ),
    );
  }
}

