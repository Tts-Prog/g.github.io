import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:flutter/material.dart';

class ThemeUtil {
  static late ThemeData _themeData;
  static late TextTheme textTheme;

  void init(BuildContext context) {
    _themeData = Theme.of(context);
    textTheme = _themeData.textTheme;
  }
}

extension TextStyleExtension on TextStyle {
  TextStyle get displaySmall => merge(ThemeUtil.textTheme.displaySmall);
  TextStyle get bodySmall => merge(ThemeUtil.textTheme.bodySmall);

  TextStyle get bodyMedium => merge(ThemeUtil.textTheme.bodyMedium);
  TextStyle get bodyLarge => merge(ThemeUtil.textTheme.bodyLarge);

  TextStyle get titleSmall => merge(ThemeUtil.textTheme.titleSmall);
  TextStyle get titleMedium => merge(ThemeUtil.textTheme.titleMedium);
  TextStyle get titleLarge => merge(ThemeUtil.textTheme.titleLarge);
  TextStyle get headlineSmall => merge(ThemeUtil.textTheme.headlineSmall);
  TextStyle get headlineMedium => merge(ThemeUtil.textTheme.headlineMedium);
  TextStyle get headlineLarge => merge(ThemeUtil.textTheme.headlineLarge);
  TextStyle get makeDefault =>
      merge(const TextStyle(color: AppColors.typographyTitle));
  //TextStyle get makeOrange => merge(TextStyle(color: AppColors.primary5));
  TextStyle get makeGrey =>
      merge(const TextStyle(color: AppColors.typographySubColor));
  TextStyle get makeWhite => merge(const TextStyle(color: Colors.white));
  //TextStyle get makeGreen => merge(TextStyle(color: AppColors.secondary5));
  //TextStyle get makeRed => merge(TextStyle(color: AppColors.maroon5));
  //onboarding custom Texts
  TextStyle get onboardingHeadline =>
      merge(ThemeUtil.textTheme.headlineMedium).merge(const TextStyle(
          fontSize: 20,
          fontFamily: 'Inter-Bold',
          fontWeight: FontWeight.w800,
          height: 0,
          letterSpacing: 0.25));

  //  TextStyle get getBodySmallTheme => merge(ThemeUtil.textTheme.bodySmall);
//TextStyle get getBodySmallTheme => merge(ThemeUtil.textTheme.bodySmall);
}

// TextStyle appTextStyle({required TextStyle theme}) {
//   return TextStyle().merge(theme);
// }
