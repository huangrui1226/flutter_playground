import 'package:dio/dio.dart';

/// 将网络请求异常转换为面向用户的中文文案。
///
/// repo 层保持只管 happy path、异常自然抛出的风格；
/// UI 层在 try/catch 中调用本函数把异常转成可展示的文案。
String dioErrorToMessage(Object error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return '连接超时，请检查网络后重试';
      case DioExceptionType.sendTimeout:
        return '发送请求超时，请稍后重试';
      case DioExceptionType.receiveTimeout:
        return '接收数据超时，请稍后重试';
      case DioExceptionType.badCertificate:
        return '证书验证失败，请检查网络环境';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        return '服务器异常${statusCode != null ? '($statusCode)' : ''}，请稍后重试';
      case DioExceptionType.cancel:
        return '请求已取消';
      case DioExceptionType.connectionError:
        return '网络连接失败，请检查网络后重试';
      case DioExceptionType.unknown:
        return '网络异常，请稍后重试';
      case DioExceptionType.transformTimeout:
        return '数据处理超时，请稍后重试';
    }
  }
  return error.toString();
}
