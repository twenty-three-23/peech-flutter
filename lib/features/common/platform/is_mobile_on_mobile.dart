import 'dart:io';

bool isMobile() {
  return true;
}

bool isUnavailableClient() {
  return false;
}

bool isIphone() {
  return Platform.isIOS;
}
