import 'dart:io';

bool isMobile() {
  return true;
}

bool isUnavailableClient() {
  return false;
}

bool isIOS() {
  return Platform.isIOS;
}

bool isAndroid() {
  return Platform.isAndroid;
}
