import 'package:translate_app/constants/app_imports.dart';

class HomeScreen extends GetWidget<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          alignment: Alignment.center,
          children: [
            Directionality(
              textDirection: controller.getStartedController.mainLanguage.value == AppStrings.arabicLanguageCode || controller.getStartedController.mainLanguage.value == AppStrings.farsiLanguageCode ? TextDirection.rtl : TextDirection.ltr,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.appDarkGray,
                appBar: AppBar(
                  surfaceTintColor: AppColors.appDarkGray,
                  foregroundColor: AppColors.appDarkGray,
                  backgroundColor: AppColors.appDarkGray,
                  leading: const GapWidget(0),
                  leadingWidth: 0,
                  elevation: 0,
                  title: Text(
                    controller.getStartedController.mainLanguage.value == AppStrings.arabicLanguageCode || controller.getStartedController.mainLanguage.value == AppStrings.farsiLanguageCode ? AppStrings.appArabicTitle : AppStrings.appTitle,
                    style: AppFonts.font20White.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.appBlue,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    right: 10.sp,
                    left: 10.sp,
                    bottom: 190.h,
                  ),
                  child: Column(
                    children: [
                      Directionality(
                        textDirection: (controller.firstLanguage.value == AppStrings.arabicLanguageCode) || controller.firstLanguage.value == AppStrings.farsiLanguageCode ? TextDirection.rtl : TextDirection.ltr,
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 25,
                          style: AppFonts.font18White,
                          cursorColor: AppColors.appWhite,
                          decoration: InputDecoration(
                            hintStyle: AppFonts.font18White.copyWith(
                              color: AppColors.appTransparentWhite,
                            ),
                            suffixIcon: controller.formFieldController.text.isEmpty || controller.formFieldController.text == AppStrings.emptySign
                                ? const GapWidget(0)
                                : InkWell(
                                    onTap: () => controller.onCopy(controller.formFieldController.text),
                                    child: Icon(
                                      Icons.copy,
                                      color: AppColors.appTransparentWhite,
                                      size: 20.sp,
                                    ),
                                  ),
                            hintText: controller.formFieldPlaceholder.value,
                            border: AppDefaults.defaultOutlineInputBorder(),
                            errorBorder: AppDefaults.defaultOutlineInputBorder(),
                            focusedBorder: AppDefaults.defaultOutlineInputBorder(),
                            enabledBorder: AppDefaults.defaultOutlineInputBorder(),
                            disabledBorder: AppDefaults.defaultOutlineInputBorder(),
                            focusedErrorBorder: AppDefaults.defaultOutlineInputBorder(),
                          ),
                          enableInteractiveSelection: false,
                          controller: controller.formFieldController,
                          onTapOutside: (value) => controller.onTapOutside(),
                          onChanged: (value) async {
                            controller.formFieldController.text = value;
                            String input = controller.formFieldController.text;
                            controller.translation.value = await controller.getStartedController.translate(
                              input,
                              from: controller.firstLanguage.value,
                              to: controller.secondLanguage.value,
                            );
                          },
                        ),
                      ),
                      Divider(
                        color: AppColors.appLightGray,
                        indent: 100.w,
                        endIndent: 100.w,
                      ),
                      Directionality(
                        textDirection: controller.secondLanguage.value == AppStrings.arabicLanguageCode || controller.secondLanguage.value == AppStrings.farsiLanguageCode ? TextDirection.rtl : TextDirection.ltr,
                        child: Row(
                          children: [
                            controller.formFieldController.text.isEmpty || controller.formFieldController.text == AppStrings.emptySign
                                ? const GapWidget(0)
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 340.w,
                                        child: Text(
                                          controller.translation.value,
                                          style: AppFonts.font20White.copyWith(
                                            color: AppColors.appTransparentWhite,
                                          ),
                                        ),
                                      ),
                                      const GapWidget(10),
                                      Container(
                                        width: 340.w,
                                        alignment: controller.secondLanguage.value == AppStrings.arabicLanguageCode || controller.secondLanguage.value == AppStrings.farsiLanguageCode ? Alignment.centerLeft : Alignment.centerRight,
                                        child: SizedBox(
                                          height: 50.sp,
                                          width: 50.sp,
                                          child: InkWell(
                                            onTap: () => controller.onCopy(controller.translation.value),
                                            child: Icon(
                                              Icons.copy,
                                              color: AppColors.appTransparentWhite,
                                              size: 20.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Container(
                  height: 200.h,
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: AppColors.appLightGray,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.sp),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.sp, 10.sp),
                        blurRadius: 25,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 500,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              gradient: LinearGradient(
                                begin: controller.languagesChanged.value ? Alignment.centerLeft : Alignment.centerRight,
                                end: controller.languagesChanged.value ? Alignment.centerRight : Alignment.centerLeft,
                                colors: const [
                                  AppColors.appLightGray,
                                  AppColors.appDarkGray,
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DropdownWidget(
                                  controller.firstLanguageDropdownController,
                                  color: AppColors.appWhite,
                                  mainLanguage: controller.getStartedController.mainLanguage.value,
                                  placeholder: controller.getStartedController.languageMenu.where((language) => language.value == controller.getStartedController.mainLanguage.value).first.label,
                                  menuList: controller.getStartedController.languageMenu,
                                  onChange: (value) async {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    controller.formFieldPlaceholder.value = await controller.getStartedController.translate(
                                      AppStrings.enterTextForTranslationText,
                                      to: value,
                                    );
                                    controller.firstLanguage.value = value;
                                    if (controller.firstLanguageDropdownController.isOpen) {
                                      controller.firstLanguageDropdownController.close();
                                    }
                                    controller.translation.value = await controller.getStartedController.translate(
                                      controller.formFieldController.text,
                                      from: value,
                                      to: controller.secondLanguage.value,
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: controller.onChangeLanguages,
                                  child: AnimatedContainer(
                                    height: 30.sp,
                                    width: 30.sp,
                                    duration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.languagesChanged.value ? AppColors.appBlue : AppColors.appTransparent,
                                      borderRadius: BorderRadius.circular(
                                        100.sp,
                                      ),
                                    ),
                                    child: Icon(
                                      controller.languagesChanged.value ? Icons.arrow_back : Icons.arrow_forward,
                                      size: 20.sp,
                                      color: AppColors.appWhite,
                                    ),
                                  ),
                                ),
                                DropdownWidget(
                                  controller.secondLanguageDropdownController,
                                  color: AppColors.appWhite,
                                  mainLanguage: controller.getStartedController.mainLanguage.value,
                                  placeholder: controller.getStartedController.languageMenu.where((language) => language.value == AppStrings.englishLanguageCode).first.label,
                                  menuList: controller.getStartedController.languageMenu,
                                  onChange: (value) async {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    controller.formFieldController.text.isEmpty
                                        ? null
                                        : controller.translation.value = await controller.getStartedController.translate(
                                            controller.formFieldController.text,
                                            from: controller.firstLanguage.value,
                                            to: value,
                                          );
                                    controller.secondLanguage.value = value;
                                    if (controller.secondLanguageDropdownController.isOpen) {
                                      controller.secondLanguageDropdownController.close();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          controller.languagesChanged.value
                              ? InkWell(
                                  onTap: controller.onChangeLanguages,
                                  child: SizedBox(
                                    height: 45.h,
                                    width: double.infinity,
                                  ),
                                )
                              : const GapWidget(0),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: controller.imageToText,
                            child: Container(
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                color: AppColors.appDarkGray,
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    color: AppColors.appWhite,
                                    size: 20.sp,
                                  ),
                                  const GapWidget(5),
                                  Text(
                                    controller.getStartedController.imageText.value,
                                    style: AppFonts.font16White.copyWith(
                                      color: AppColors.appWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AvatarGlow(
                            animate: controller.isListening.value,
                            glowColor: AppColors.appDarkGray,
                            glowShape: BoxShape.rectangle,
                            glowBorderRadius: BorderRadius.circular(15.sp),
                            glowCount: 2,
                            duration: const Duration(
                              seconds: 1,
                            ),
                            repeat: true,
                            child: InkWell(
                              onTap: controller.soundToText,
                              child: AnimatedPadding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: controller.isListening.value ? 50.w : 0.w,
                                ),
                                duration: const Duration(
                                  milliseconds: 500,
                                ),
                                child: AnimatedContainer(
                                  height: 50.h,
                                  width: controller.isListening.value ? 50.w : 150.w,
                                  duration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  onEnd: () => controller.animationEnds.value = true,
                                  decoration: BoxDecoration(
                                    color: AppColors.appDarkGray,
                                    borderRadius: BorderRadius.circular(15.sp),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        controller.isListening.value ? Icons.mic_none : Icons.mic,
                                        color: AppColors.appWhite,
                                        size: 20.sp,
                                      ),
                                      controller.isListening.value
                                          ? const GapWidget(0)
                                          : controller.animationEnds.value
                                              ? const GapWidget(5)
                                              : const GapWidget(0),
                                      controller.isListening.value
                                          ? const GapWidget(0)
                                          : controller.animationEnds.value
                                              ? Text(
                                                  controller.getStartedController.soundText.value,
                                                  style: AppFonts.font16White.copyWith(
                                                    color: AppColors.appWhite,
                                                  ),
                                                )
                                              : const GapWidget(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            controller.getStartedController.isLoading.value
                ? Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: AppColors.appDarkGray,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const GapWidget(10),
                              InkWell(
                                onTap: () => controller.zoom.value != controller.zoom.value,
                                child: AnimatedContainer(
                                  duration: const Duration(
                                    seconds: 1,
                                  ),
                                  curve: Curves.easeInOut,
                                  width: 100.sp * controller.scale.value,
                                  height: 100.sp * controller.scale.value,
                                  onEnd: () => controller.startAnimation,
                                  child: Image.asset(AppStrings.appLogoImage),
                                ),
                              ),
                              const GapWidget(10),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 50.sp,
                            ),
                            child: Text(
                              AppStrings.appTitle,
                              style: AppFonts.font24White.copyWith(
                                color: AppColors.appBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const GapWidget(0),
          ],
        );
      },
    );
  }
}
