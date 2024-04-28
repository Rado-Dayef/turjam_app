import 'package:translate_app/constants/app_imports.dart';
import 'package:translator/translator.dart';

class GetStartedController extends GetxController {
  late SharedPreferences prefs;
  RxBool isLoading = RxBool(true);
  AppDatabase database = AppDatabase();
  RxBool showGetStarted = RxBool(true);
  GoogleTranslator translator = GoogleTranslator();
  RxString soundText = RxString(AppStrings.soundText);
  RxString imageText = RxString(AppStrings.imageText);
  RxString mainLanguage = RxString(AppStrings.emptySign);
  RxString copiedToastText = RxString(AppStrings.copiedToast);
  RxString micSupportToastText = RxString(AppStrings.micSupportToast);
  RxString imageSupportToastText = RxString(AppStrings.imageSupportToast);
  DropdownController mainLanguageDropdownController = DropdownController();
  RxList<CoolDropdownItem<String>> languageMenu = RxList<CoolDropdownItem<String>>([
    CoolDropdownItem(
      label: AppStrings.japaneseLanguageName,
      value: AppStrings.japaneseLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.swedishLanguageName,
      value: AppStrings.swedishLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.italianLanguageName,
      value: AppStrings.italianLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.englishLanguageName,
      value: AppStrings.englishLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.spanishLanguageName,
      value: AppStrings.spanishLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.turkishLanguageName,
      value: AppStrings.turkishLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.chineseLanguageName,
      value: AppStrings.chineseLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.russianLanguageName,
      value: AppStrings.russianLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.germanLanguageName,
      value: AppStrings.germanLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.frenchLanguageName,
      value: AppStrings.frenchLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.arabicLanguageName,
      value: AppStrings.arabicLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.koreanLanguageName,
      value: AppStrings.koreanLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.farsiLanguageName,
      value: AppStrings.farsiLanguageCode,
    ),
    CoolDropdownItem(
      label: AppStrings.hindiLanguageName,
      value: AppStrings.hindiLanguageCode,
    ),
  ]);

  @override
  void onInit() async {
    super.onInit();
    await initPrefs();
  }

  /// To initialize all the local data.
  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    bool hasSeenGetStartedScreen = prefs.getBool(AppStrings.getStartedText) ?? false;
    showGetStarted.value = !hasSeenGetStartedScreen;
    if (!showGetStarted.value) {
      soundText.value = prefs.getString(AppStrings.soundText) ?? AppStrings.soundText;
      imageText.value = prefs.getString(AppStrings.imageText) ?? AppStrings.imageText;
      copiedToastText.value = prefs.getString(AppStrings.copiedToast) ?? AppStrings.copiedToast;
      mainLanguage.value = prefs.getString(AppStrings.mainLanguageText) ?? AppStrings.emptySign;
      micSupportToastText.value = prefs.getString(AppStrings.micSupportToast) ?? AppStrings.micSupportToast;
      imageSupportToastText.value = prefs.getString(AppStrings.imageSupportToast) ?? AppStrings.imageSupportToast;
      await fetchLanguageMenu().then(
        (value) => Future.delayed(
          const Duration(seconds: 4),
          () {
            isLoading.value = false;
          },
        ),
      );
    }
  }

  /// To mark the get started screen as seen and store the app values in shared preferences based on the user main language.
  /// This function works only the first time.
  Future<void> markGetStartedScreenAsSeen() async {
    if (mainLanguage.value == AppStrings.emptySign) {
      AppDefaults.defaultToast(AppStrings.selectYourMainLanguageToast);
    } else {
      await database.initDb();
      showGetStarted.value = false;
      await prefs.setBool(AppStrings.getStartedText, true);
      await database.insertLanguageMenu(languageMenu, this);
      await prefs.setString(AppStrings.mainLanguageText, mainLanguage.value);
      await prefs.setString(AppStrings.soundText, await translate(AppStrings.soundText)).then((value) => soundText.value = prefs.getString(AppStrings.soundText) ?? AppStrings.soundText);
      await prefs.setString(AppStrings.imageText, await translate(AppStrings.imageText)).then((value) => imageText.value = prefs.getString(AppStrings.imageText) ?? AppStrings.imageText);
      await prefs.setString(AppStrings.copiedToast, await translate(AppStrings.copiedToast)).then((value) => copiedToastText.value = prefs.getString(AppStrings.copiedToast) ?? AppStrings.copiedToast);
      await prefs.setString(AppStrings.micSupportToast, await translate(AppStrings.micSupportToast)).then((value) => micSupportToastText.value = prefs.getString(AppStrings.micSupportToast) ?? AppStrings.micSupportToast);
      await prefs.setString(AppStrings.imageSupportToast, await translate(AppStrings.imageSupportToast)).then((value) => imageSupportToastText.value = prefs.getString(AppStrings.imageSupportToast) ?? AppStrings.imageSupportToast);
      await initPrefs();
    }
  }

  /// To fetch the language menu from the local database.
  Future<void> fetchLanguageMenu() async {
    List<Map<String, dynamic>> rows = await database.readData(AppStrings.selectAllFromLanguageTableDB);
    List<CoolDropdownItem<String>> menu = rows.map((row) {
      return CoolDropdownItem<String>(
        label: row[AppStrings.labelFieldDB].toString(),
        value: row[AppStrings.valueFieldDB].toString(),
      );
    }).toList();
    languageMenu.value = menu;
  }

  /// To translate text from language to another language.
  Future<String> translate(String translate, {String? from, String? to}) async {
    Translation translation = await translator.translate(
      translate,
      from: from ?? AppStrings.englishLanguageCode,
      to: to ?? mainLanguage.value,
    );
    String translationText = translation.text;
    return translationText;
  }
}
