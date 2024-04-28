import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translate_app/constants/app_imports.dart';

class HomeController extends GetxController {
  double confidence = 1.0;
  stt.SpeechToText? speech;
  RxBool zoom = RxBool(true);
  RxDouble scale = RxDouble(1.0);
  ImagePicker picker = ImagePicker();
  RxBool isListening = RxBool(false);
  RxBool animationEnds = RxBool(true);
  RxBool languagesChanged = RxBool(false);
  RxString translation = RxString(AppStrings.emptySign);
  GetStartedController getStartedController = Get.find();
  RxString firstLanguage = RxString(AppStrings.emptySign);
  RxString secondLanguage = RxString(AppStrings.englishLanguageCode);
  TextEditingController formFieldController = TextEditingController();
  DropdownController firstLanguageDropdownController = DropdownController();
  DropdownController secondLanguageDropdownController = DropdownController();
  RxString formFieldPlaceholder = RxString(AppStrings.enterTextForTranslationText);

  @override
  void onInit() async {
    super.onInit();
    firstLanguage.value = getStartedController.mainLanguage.value;
    formFieldPlaceholder.value = await getStartedController.translate(
      AppStrings.enterTextToTranslateText,
      to: firstLanguage.value,
    );
    startAnimation();
    speech = stt.SpeechToText();
  }

  /// To listen to the mic after the user click the sound button.
  void soundToText() async {
    if (firstLanguage.value == AppStrings.englishLanguageCode) {
      if (!isListening.value) {
        bool available = await speech!.initialize(
          onStatus: (value) {},
          onError: (value) {},
        );
        if (available) {
          isListening.value = true;
          speech!.listen(
            onResult: (input) async {
              formFieldController.text = input.recognizedWords;
              translation.value = await getStartedController.translate(
                input.recognizedWords,
                from: firstLanguage.value,
                to: secondLanguage.value,
              );
              if (input.hasConfidenceRating && input.confidence > 0) {
                confidence = input.confidence;
              }
            },
          );
        }
      } else {
        isListening.value = false;
        speech!.stop();
      }
      animationEnds.value = false;
      FocusManager.instance.primaryFocus?.unfocus();
    } else {
      AppDefaults.defaultToast(getStartedController.micSupportToastText.value);
    }
  }

  /// To detect the text from an image.
  Future<void> imageToText() async {
    if (firstLanguage.value == AppStrings.englishLanguageCode) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      final textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final RecognizedText recognizedText = await textRecognizer.processImage(InputImage.fromFilePath(image!.path));
      String input = recognizedText.text.toString();
      formFieldController.text = input;
      translation.value = await getStartedController.translate(
        input,
        from: firstLanguage.value,
        to: secondLanguage.value,
      );
    } else {
      AppDefaults.defaultToast(getStartedController.imageSupportToastText.value);
    }
  }

  /// This function to copy text to clipboard.
  void onCopy(String text) {
    Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
    AppDefaults.defaultToast(getStartedController.copiedToastText.value);
  }

  /// This function to handel the logic when the user taps outside of the TextFormField.
  void onTapOutside() async {
    FocusManager.instance.primaryFocus?.unfocus();
    String input = formFieldController.text;
    translation.value = await getStartedController.translate(
      input,
      from: firstLanguage.value,
      to: secondLanguage.value,
    );
  }

  /// To change the languages from first second and from second to first.
  void onChangeLanguages() async {
    final String originalTranslation = translation.value;
    final String originalFirstLanguage = firstLanguage.value;
    final String originalSecondLanguage = secondLanguage.value;
    secondLanguage.value = originalFirstLanguage;
    firstLanguage.value = originalSecondLanguage;
    formFieldController.text = originalTranslation;
    languagesChanged.value = !languagesChanged.value;
    translation.value = await getStartedController.translate(
      originalTranslation,
      from: firstLanguage.value,
      to: secondLanguage.value,
    );
    formFieldPlaceholder.value = await getStartedController.translate(
      AppStrings.enterTextToTranslateText,
      to: firstLanguage.value,
    );
  }

  /// To start the splash animation.
  void startAnimation() {
    Future.delayed(
      Duration.zero,
      () {
        scale.value = 2.0;
        Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () {
            scale.value = 1.0;
            endAnimation();
          },
        );
      },
    );
  }

  /// To end the splash animation.
  void endAnimation() {
    Future.delayed(
      Duration.zero,
      () {
        scale.value = 1.0;
        Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () {
            scale.value = 2.0;
            startAnimation();
          },
        );
      },
    );
  }
}
