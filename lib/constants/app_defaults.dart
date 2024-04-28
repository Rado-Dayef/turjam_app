import 'package:translate_app/constants/app_imports.dart';

class AppDefaults {
  static OutlineInputBorder defaultOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.sp),
      borderSide: const BorderSide(
        color: AppColors.appTransparent,
      ),
    );
  }

  static Future<bool?> defaultToast(String text) {
    return Fluttertoast.showToast(
      msg: text,
      backgroundColor: AppColors.appTransparentWhite,
      textColor: AppColors.appDarkGray,
      fontSize: 14.sp,
    );
  }
}
