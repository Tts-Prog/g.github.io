import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/theme_utilities/lightTheme.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/textfields/custom_text_fields.dart';
import 'package:ame/resources/utilities/textfields/password_form_field.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';

import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'sign_up_view_model.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late SignUpViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign Up",
                        style: const TextStyle().titleMedium,
                      ).spaceTo(bottom: 20.h),
                    ),
                    CustomInputFields(
                      iconPresent: true,
                      keyboardType: TextInputType.emailAddress,
                      prefix: ViewUtil.imageAsset4Scale(
                          asset: AppAssets.profileTextFdIcon),
                      labelText: "Full name",
                    ).spaceTo(bottom: 20.h),
                    CustomInputFields(
                      iconPresent: true,
                      keyboardType: TextInputType.emailAddress,
                      prefix: ViewUtil.imageAsset4Scale(
                          asset: AppAssets.emailTextFdIcon),
                      labelText: "abc@email.com",
                    ).spaceTo(bottom: 20.h),
                    const PasswordTextField(
                      keyboardType: TextInputType.text,
                      hintText: "Your Password",
                    ).spaceTo(bottom: 20.h),
                    const PasswordTextField(
                      keyboardType: TextInputType.text,
                      hintText: "Your Password",
                    ).spaceTo(bottom: 20.h),
                    ElevatedButton(
                            onPressed: () {}, child: const Text("SIGN UP"))
                        .spaceTo(bottom: 30.h),
                    const Text(
                      "OR",
                      style: TextStyle(color: Colors.grey),
                    ).spaceTo(bottom: 10.h),
                    customButton(
                        onPressed: () {},
                        buttonColor: Colors.white,
                        buttonLogo: AppAssets.googleLogo,
                        textColor: AppColors.typographyTitle,
                        buttonText: "Log in with Google"),
                  ],
                ).spaceSymmetrically(horizontal: 16, vertical: 24),
                ViewUtil.bonakoTrademark().spaceTo(top: 80.h)
              ],
            ).spaceTo(bottom: 24),
          )),
    );
  }

  Widget customButton(
      {required VoidCallback onPressed,
      required buttonLogo,
      required String buttonText,
      required Color buttonColor,
      required Color textColor}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 56.h,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ViewUtil.imageAsset4Scale(asset: buttonLogo).spaceTo(right: 25),
            Text(
              buttonText,
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ).spaceSymmetrically(vertical: 10, horizontal: 30),
    );
  }
}
