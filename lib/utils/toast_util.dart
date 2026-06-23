import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class ToastUtil {
  // 私有静态实例变量
  static ToastUtil? _instance;

  // 私有构造函数
  ToastUtil._();

  // 静态工厂方法获取单例实例
  factory ToastUtil() {
    _instance ??= ToastUtilImpl();
    return _instance!;
  }

  Future<void> init();
  Future<void> show();
  Future<void> hide();
}

class ToastUtilImpl extends ToastUtil {
  ToastUtilImpl() : super._();

  @override
  Future<void> init() async {}

  @override
  Future<void> show() async {
    EasyLoading.showToast("This is a toast");
  }

  @override
  Future<void> hide() async {
    EasyLoading.dismiss();
  }
}
