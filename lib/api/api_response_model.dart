class ApiResponseModel<T> {
  /// 状态码
  int? code;

  /// 状态提示
  String? message;

  /// 时间戳
  String? timestamp;

  /// 业务数据
  T? data;

  /// 接口请求是否成功
  bool isSuccess() {
    return code == 200;
  }

  ApiResponseModel({this.code, this.message, this.timestamp, this.data});

  ApiResponseModel.success({this.code = 200, this.message, this.data});

  ApiResponseModel.failure({this.code = -1, this.message});

  @override
  String toString() {
    return 'ApiResponseModel => code:$code, message:$message, data:$data';
  }

  static const networkError = 'Network Error';
}

// /// 请求异常
// class RequestException extends ApiResponseModel {
//   RequestException(int code, String message)
//       : super.failure(code: code, message: message);
// }
//
// /// 网络异常
// class NetworkException extends RequestException {
//   NetworkException(int statusCode, String message) : super(-1, message);
// }
//
// /// 授权异常
// class UnauthorisedException extends RequestException {
//   UnauthorisedException(super.code, super.message);
// }
