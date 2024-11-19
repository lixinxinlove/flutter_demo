import 'dart:io';

import 'package:dio/dio.dart';

import 'api_response_model.dart';
import 'http_client/http_client.dart';

class Api {
  ///查询设备终端
  static Future<ApiResponseModel<String>> adjustDevice(
      {required String adId}) async {
    Response response = await HttpClient().getDio().get(
        " AppConstants.adjustInspectDeviceUrl",
        queryParameters: {
          "app_token": " AppConstants.adjustInspectDeviceUrl",
          "advertising_id": adId,
        },
        options: Options(
            headers: {"Authorization": "Bearer AppConstants.adjustApiCode"}));

    print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    print(response.data);
    print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");

    Map<String, dynamic> map = response.data;

    String data = map['FirstTrackerName'];

    return ApiResponseModel(code: 200, message: "", data: data);
  }

  ///
  static Future<bool> deepAd(String url) async {
    Dio _dio = Dio();
    Response response = await _dio.get(url);
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return true;
    }
    return false;
  }
}
