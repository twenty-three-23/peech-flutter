import 'dart:html' as html;

bool isMobile() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  print('userAgent: $userAgent');
  return userAgent.contains('iphone') || userAgent.contains('ipad') || userAgent.contains('android');
}

bool isRecordUnavailableClient() {
  return isIOS() || isSafari();
}

bool isSafari() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('safari') && !userAgent.contains('chrome');
}

bool isIOS() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('iphone');
}

bool isAndroid() {
  final userAgent = html.window.navigator.userAgent.toLowerCase();
  return userAgent.contains('android');
}
