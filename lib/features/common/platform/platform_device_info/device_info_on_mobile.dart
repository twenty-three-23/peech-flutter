import 'dart:io';

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
