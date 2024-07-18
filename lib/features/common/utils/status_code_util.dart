class StatusCodeUtil {

  static String getMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return '잘못된 요청입니다.';
      case 401:
        return '인증 오류입니다. 다시 로그인해주세요.';
      case 403:
        return '접근이 거부되었습니다.';
      case 404:
        return '요청한 자원을 찾을 수 없습니다.';
      case 500:
        return '서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.';
      default:
        return '알 수 없는 오류가 발생했습니다. 오류 코드: $statusCode';
    }
  }

  static int getStatusCodeFromErrorMessage(String message) {
    int statusCode = -1;
    try {
      statusCode = int.parse(message.split('status code of')[1].split('and')[0]);
    } catch (e) {
      print("statusCode 파싱 실패: $e");
    }
    print("statusCode: $statusCode");
    return statusCode;
  }

}