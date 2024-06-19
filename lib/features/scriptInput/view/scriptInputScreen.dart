import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swm_peech_flutter/features/scriptInput/viewModel/state/scriptInputViewModelState.dart';

import '../viewModel/scriptInputViewModel.dart';

class ScriptInputScreen extends ConsumerWidget {
  const ScriptInputScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ScriptInputViewModelState viewModelState = ref.watch(scriptInputViewModel);
    ScriptInputViewModel viewModel = ref.watch(scriptInputViewModel.notifier);
    final scriptController = TextEditingController();
    ref.listen(scriptInputViewModel, (previous, next) { debugPrint("prev: ${previous?.script}, next: ${next.script}"); });

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
                child: TextField(
                  minLines: 1,
                  maxLines: null,
                  onChanged: (value) {
                    viewModel.setScript(value);
                  },
                  decoration: InputDecoration(
                    hintText: "안녕하세요. 발표 시작하겠습니다...",
                    border: const OutlineInputBorder(),
                    counterText: "${viewModelState.script?.length ?? 0} 자"
                  ),
                ),
              ),
            ),
            TextButton(
                onPressed: () {  },
                child: const Text("예상 시간 확인")
            ),
          ],
        ),
      ),
    );
  }
}

