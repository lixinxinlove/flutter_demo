import 'dart:convert';

import 'package:dio/dio.dart';

import 'http_response_model.dart';

import 'http_client.dart' as h;

class HttpInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sysLanguage = "en";
    if (h.HttpClient.countrys.contains(sysLanguage)) {
      options.queryParameters['country'] = sysLanguage;
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      if (response.data is Map) {
        HttpResponseModel responseModel =
            HttpResponseModel.fromJson(response.data);
        if (responseModel.code == 599) {
          print("599 需要登录0");

        } else if (responseModel.code == 500003) {
          /// 用户已被拉黑，不允许登录

        }else if (responseModel.code == 500004) {
          /// 用户没有注册

        }
      } else if (response.data is String) {
        Map<String, dynamic> map = jsonDecode(response.data);
        int code = map["code"] as int;
        if (code == 599) {
          print("599 需要登录");
          print(response.realUri);


        } else if (code == 500003) {
          /// 用户已被拉黑，不允许登录

        } else if (code == 500004) {
          print(code);
          print("用户没有注册");
          /// 用户没有注册

        }
      }
    } else {
      throwError(response);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }

  void throwError(Response<dynamic> response) {
    throw DioException(
        requestOptions: response.requestOptions,
        error: NetworkException(-1, response.statusMessage ?? ""));
  }
}
