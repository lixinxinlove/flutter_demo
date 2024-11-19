class HttpResponseModel {
  HttpResponseModel({
    this.code,
    this.message,
    this.timestamp,
  });

  HttpResponseModel.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
    timestamp = json['timestamp'];
    data = json['data'];
  }

  int? code;
  String? message;
  dynamic data;
  String? timestamp;

  bool isSuccess() {
    return code == 200;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    map['timestamp'] = timestamp;
    map['data'] = data;
    return map;
  }

  HttpResponseModel.success({this.code = 200, this.message, this.data});

  HttpResponseModel.failure({this.code = -1, this.message});

  @override
  String toString() {
    return 'HttpResponseModel => code:$code, message:$message, data:$data';
  }
}

/// 请求异常
class RequestException extends HttpResponseModel {
  RequestException(int code, String message)
      : super.failure(code: code, message: message);
}

/// 网络异常
class NetworkException extends RequestException {
  NetworkException(int statusCode, String message) : super(-1, message);
}

/// 授权异常
class UnauthorisedException extends RequestException {
  UnauthorisedException(super.code, super.message);
}
