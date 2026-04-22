import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'file_logger_util.dart';

class NetworkLoggerInterceptor extends LogInterceptor {
  NetworkLoggerInterceptor()
    : super(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        logPrint: (object) {
          FileLoggerUtil().log(object.toString());
        },
      );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logPrint('${options.method} -> ${options.uri}');
    logPrint('data: ${options.data}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logPrint('${response.statusCode} <- ${response.requestOptions.uri}');
    logPrint('data: ${response.description}');
    handler.next(response);
  }
}

extension ResponsePrint on Response {
  String get description {
    if (data is Map) {
      final simpleData = Map.of(data);
      if (!kDebugMode) {
        simpleData.remove('data');
      }
      return jsonEncode(simpleData);
    }
    return data.toString();
  }
}
