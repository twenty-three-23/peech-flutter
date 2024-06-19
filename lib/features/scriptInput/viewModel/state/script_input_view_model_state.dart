
class ScriptInputViewModelState {

  final String? script;

  ScriptInputViewModelState({this.script});

  ScriptInputViewModelState copyWith({String? script}) {
    return ScriptInputViewModelState(script: script);
  }


}