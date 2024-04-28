import 'package:translate_app/constants/app_imports.dart';

class GetStartedScreen extends GetWidget<GetStartedController> {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.appDarkGray,
      body: Obx(
        () {
          return controller.showGetStarted.value
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppStrings.getStartedImage),
                        const GapWidget(10),
                        Text(
                          AppStrings.appTitle,
                          style: AppFonts.font40White.copyWith(
                            color: AppColors.appBlue,
                          ),
                        ),
                        Text(
                          AppStrings.appSubtitle,
                          style: AppFonts.font16White,
                        ),
                        const GapWidget(25),
                        DropdownWidget(
                          controller.mainLanguageDropdownController,
                          subWidth: 350.w,
                          mainHeight: 50.h,
                          mainWidth: 300.w,
                          withBoxDecoration: true,
                          subAlign: MainAxisAlignment.start,
                          mainAlign: MainAxisAlignment.start,
                          menuList: controller.languageMenu,
                          mainLanguage: controller.mainLanguage.value,
                          placeholder: AppStrings.chooseYourMainLanguageText,
                          onChange: (value) {
                            controller.mainLanguage.value = value;
                            if (controller.mainLanguageDropdownController.isOpen) {
                              controller.mainLanguageDropdownController.close();
                            }
                          },
                        ),
                        const GapWidget(25),
                        InkWell(
                          onTap: controller.markGetStartedScreenAsSeen,
                          child: AnimatedContainer(
                            height: 40.h,
                            width: 150.w,
                            duration: const Duration(
                              seconds: 1,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: controller.mainLanguage.value == AppStrings.emptySign ? AppColors.appDarkGray : AppColors.appBlue,
                              borderRadius: BorderRadius.circular(15.sp),
                              border: Border.all(
                                color: controller.mainLanguage.value == AppStrings.emptySign ? AppColors.appBlue : AppColors.appDarkGray,
                              ),
                            ),
                            child: Text(
                              AppStrings.getStartedText,
                              style: AppFonts.font20White.copyWith(
                                color: controller.mainLanguage.value == AppStrings.emptySign ? AppColors.appBlue : AppColors.appDarkGray,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const HomeScreen();
        },
      ),
    );
  }
}
