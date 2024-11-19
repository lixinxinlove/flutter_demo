import 'dart:io';

import 'package:dd_check_plugin/dd_check_plugin.dart';
import 'package:dd_check_plugin/model/send_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../utils/log.dart';
import '../api_config.dart';
import 'http_interceptors.dart';
import 'http_response_model.dart';

class HttpClient {
  HttpClient._internal() {
    _dio.interceptors.add(HttpInterceptors());

    if (!kReleaseMode) {
      final PrettyDioLogger logger = PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: false,
          maxWidth: 150);
      _dio.interceptors.add(logger);

      DdCheckPlugin().init(_dio,
          initHost: "192.168.1.218",
          port: 9999,
          projectName: 'PlayHive',
          customCoverterResponseData: _customCoverterResponseData);
    }
  }

  static final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  final Dio _dio = Dio();

  ///语言code "en,th"
  static String countrys = "";

  Future<HttpResponseModel> get(
    String url, {
    String? baseUrl,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Dio dio = getDio(baseUrl: baseUrl, headers: headers);
      final response = await dio.get(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _handleResponse(response);
    } on Exception catch (e) {
      return _handleException(e);
    }
  }

  Future<HttpResponseModel> post(
    String url, {
    String? baseUrl,
    Object? data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Dio dio = getDio(baseUrl: baseUrl, headers: headers);
      final response = await dio.post(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _handleResponse(response);
    } on Exception catch (e) {
      return _handleException(e);
    }
  }

  Future<HttpResponseModel> put(
    String url, {
    String? baseUrl,
    Object? data,
    Map<String, dynamic>? params,
    Map<String, dynamic>? headers,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Dio dio = getDio(baseUrl: baseUrl, headers: headers);
      final response = await dio.put(url,
          data: data,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
      return _handleResponse(response);
    } on Exception catch (e) {
      return _handleException(e);
    }
  }

  /// 处理接口响应
  HttpResponseModel _handleResponse(Response? response) {
    if (response == null) {
      return RequestException(0, 'A null exception is returned!');
    }

    try {
      final responseData = HttpResponseModel.fromJson(response.data);
      switch (responseData.code) {
        case 401:
          return UnauthorisedException(
              responseData.code!, responseData.message ?? '');
        default:
          break;
      }
      return responseData;
    } catch (_) {
      return RequestException(-1, 'Unknown error');
    }
  }

  /// 处理接口异常
  HttpResponseModel _handleException(Exception exception) {
    Log.d(exception);
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.cancel:
        case DioExceptionType.connectionError:
          return NetworkException(
              exception.response?.statusCode ?? -1, exception.message ?? '');
        case DioExceptionType.badCertificate:
          return UnauthorisedException(
              exception.response?.statusCode ?? -1, exception.message ?? '');
        case DioExceptionType.badResponse:
          return RequestException(-1, exception.message ?? '');
        case DioExceptionType.unknown:
          if (exception is SocketException) {
            return NetworkException(
                exception.response?.statusCode ?? -1, exception.message ?? '');
          }
          return RequestException(-1, exception.message ?? '');
        default:
          return RequestException(-1, exception.message ?? '');
      }
    }

    return RequestException(0, exception.toString());
  }
}

extension HttpConfig on HttpClient {
  /// 获取dio实例
  Dio getDio({String? baseUrl, Map<String, dynamic>? headers}) {
    const timeout = Duration(seconds: 30);
    final BaseOptions options = BaseOptions(
        baseUrl: baseUrl ?? ApiConfig.baseUrl,
        contentType: 'application/json',
        headers: _headers(headers),
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: timeout,
        receiveTimeout: timeout);
    _dio.options = options;
    return _dio;
  }

  /// 获取http headers
  Map<String, dynamic> _headers(Map<String, dynamic>? precedence) {
    Map<String, dynamic> headers = {
      "Content-Type": "application/json",
      'Authorization': "",
    };

    // headers[HttpHeaders.userAgentHeader] = AppInfoManager().info.ua;

    if (precedence != null) {
      headers.addAll(precedence);
    }

    print("*****************headers**************************");
    print(headers);
    print("&&&&&&&&&&&&&&&&&headers&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    return headers;
  }

  ///&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

  SendResponseModel _customCoverterResponseData(
      SendResponseModel sendResponseModel) {
    final notes = <String>[];
    if (sendResponseModel.url.contains("/api/magic/imagetovideostyle")) {
      notes.add("132、生成视频（图生视频）");
    } else if (sendResponseModel.url
        .contains("/api/noauth/v3/appversionconfig")) {
      notes.add("122、获取app版本配置-v3");
    } else if (sendResponseModel.url
        .contains("/api/magic/imagerecordset/detail/queue")) {
      notes.add("130、图片集合详情 - 排队信息");
    }
    notes.add(
        "${sendResponseModel.response?.data.runtimeType}"); //添加response返回类型
    return sendResponseModel.copyWith(extendNotes: notes);
  }
}
