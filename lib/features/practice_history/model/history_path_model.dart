import 'package:get/get.dart';

enum HistoryPathState {
  themeList,
  majorList,
  minorList,
  minorDetail,
}

class HistoryPathModel {

  //경로는 Theme/Major/Minor 형식

  HistoryPathState pathState = HistoryPathState.themeList;
  int? _theme;
  int? _major;
  int? _minor;

  int? get theme { return _theme; }

  int? get major { return _major; }

  int? get minor { return _minor; }

  //테마 선택: theme는 선택한 값, 이후 경로는 null로 설정
  bool setTheme(int? theme) {
    _theme = theme;
    _major = null;
    _minor = null;
    return true;
  }

  //Major 선택: major는 선택한 값, 이후 경로는 null로 설정
  bool setMajor(int? major) {
    if(_theme == null) return false;
    _major = major;
    _minor = null;
    return true;
  }

  //Minor 선택: minor는 선택한 값, 이후 경로는 null로 설정
  bool setMinor(int? minor) {
    if(_theme == null) return false;
    if(_major == null) return false;
    _minor = minor;
    return true;
  }

  //이전 경로로 돌아가기
  void back() {
    switch(pathState) {
      case HistoryPathState.minorDetail:
        setMinor(null);
        break;
      case HistoryPathState.minorList:
        setMajor(null);
        break;
      case HistoryPathState.majorList:
        setTheme(null);
        break;
      case HistoryPathState.themeList:
        break;
    }
  }

  //이전 경로의 특정 순간으로 돌아가기
  void setPrevPath(HistoryPathState path) {
    switch(path) {
      case HistoryPathState.themeList:
        setTheme(null);
        break;
      case HistoryPathState.majorList:
        setTheme(_theme);
        break;
      case HistoryPathState.minorList:
        setMajor(_major);
        break;
      case HistoryPathState.minorDetail:
        setMinor(minor);
        break;
    }
  }

}