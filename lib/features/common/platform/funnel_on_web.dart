import 'dart:html' as html;

String getFunnel() {
  // 현재 브라우저 URL에서 쿼리 파라미터 가져오기
  Uri uri = Uri.parse(html.window.location.href);
  final siteParam = uri.queryParameters['site'];
  return siteParam ?? '';
}
