import 'dart:io';

String get type {
  if (isIOS()) {
    return 'iOS';
  } else if (isAndroid()) {
    return 'Android';
  } else {
    return '?';
  }
}

bool isWeb() {
  return false;
}

bool isMobile() {
  return true;
}

bool isRecordUnavailableClient() {
  return false;
}

bool isSafari() {
  return false;
}

bool isIOS() {
  return Platform.isIOS;
}

bool isAndroid() {
  return Platform.isAndroid;
}
