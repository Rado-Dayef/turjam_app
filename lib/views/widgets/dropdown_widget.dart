import 'package:translate_app/constants/app_imports.dart';

class DropdownWidget extends StatelessWidget {
  final List<CoolDropdownItem<String>> menuList;
  final DropdownController dropdownController;
  final dynamic Function(String) onChange;
  final MainAxisAlignment? mainAlign;
  final MainAxisAlignment? subAlign;
  final bool? withBoxDecoration;
  final String mainLanguage;
  final String placeholder;
  final double? mainHeight;
  final double? mainWidth;
  final double? subWidth;
  final Color? color;

  const DropdownWidget(
    this.dropdownController, {
    required this.mainLanguage,
    required this.placeholder,
    this.withBoxDecoration,
    required this.menuList,
    required this.onChange,
    this.mainHeight,
    this.mainWidth,
    this.mainAlign,
    this.subWidth,
    this.subAlign,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CoolDropdown<String>(
      isMarquee: false,
      dropdownItemOptions: DropdownItemOptions(
        isMarquee: false,
        textStyle: AppFonts.font16White,
        textOverflow: TextOverflow.ellipsis,
        mainAxisAlignment: subAlign ?? (mainLanguage == AppStrings.arabicLanguageCode || mainLanguage == AppStrings.farsiLanguageCode ? MainAxisAlignment.end : MainAxisAlignment.start),
        selectedBoxDecoration: const BoxDecoration(
          color: AppColors.appDarkGray,
        ),
        selectedTextStyle: AppFonts.font16White.copyWith(
          color: AppColors.appLightGray,
        ),
      ),
      dropdownOptions: DropdownOptions(
        height: 250.h,
        width: subWidth ?? 150.w,
        color: AppColors.appDarkGray,
      ),
      resultOptions: ResultOptions(
        height: mainHeight ?? 35.h,
        width: mainWidth ?? 100.w,
        mainAxisAlignment: mainAlign ?? MainAxisAlignment.center,
        textOverflow: TextOverflow.ellipsis,
        textStyle: AppFonts.font16White,
        boxDecoration: withBoxDecoration ?? false
            ? BoxDecoration(
                color: AppColors.appDarkGray,
                borderRadius: BorderRadius.circular(15.sp),
                border: Border.all(
                  color: AppColors.appLightGray,
                ),
              )
            : const BoxDecoration(),
        openBoxDecoration: const BoxDecoration(),
        errorBoxDecoration: const BoxDecoration(),
        placeholder: placeholder,
        placeholderTextStyle: AppFonts.font16White.copyWith(
          color: color ?? AppColors.appWhite,
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: color ?? AppColors.appWhite,
          size: 18.sp,
        ),
      ),
      dropdownList: menuList,
      controller: dropdownController,
      onChange: onChange,
    );
  }
}
