import 'package:translate_app/constants/app_imports.dart';

void main() async {
  final window = WidgetsFlutterBinding.ensureInitialized().window;
  await ScreenUtil.ensureScreenSize(window);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.appTransparent,
      ),
    );
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(
            splashColor: AppColors.appTransparent,
            highlightColor: AppColors.appTransparent,
            textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: AppColors.appWhite,
              selectionColor: AppColors.appLightGray,
            ),
          ),
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          initialBinding: AppBinding(),
          getPages: appRoutes,
          initialRoute: AppStrings.getStartedRoute,
        );
      },
    );
  }
}
