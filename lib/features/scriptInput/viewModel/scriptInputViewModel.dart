import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swm_peech_flutter/features/scriptInput/viewModel/state/scriptInputViewModelState.dart';


final scriptInputViewModel = StateNotifierProvider<ScriptInputViewModel, ScriptInputViewModelState>(
        (ref) { return ScriptInputViewModel(); });

class ScriptInputViewModel extends StateNotifier<ScriptInputViewModelState>{

  ScriptInputViewModel() : super(ScriptInputViewModelState());

  void setScript(String? script) {
    state = state.copyWith(script: script);
  }


}