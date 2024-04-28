import 'package:translate_app/constants/app_imports.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut(
      () => GetStartedController(),
      fenix: true,
    );
  }
}
