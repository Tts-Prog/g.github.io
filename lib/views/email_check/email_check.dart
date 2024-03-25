import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:ame/views/signin/signin.dart';
import 'package:ame/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/theme_utilities/app_colors.dart';
import '../../resources/utilities/app_assets.dart';
import '../../resources/utilities/textfields/custom_text_fields.dart';
import '../../resources/utilities/validation_util.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import 'email_check_view_model.dart';

class EmailCheck extends StatefulWidget {
  const EmailCheck({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<EmailCheck> createState() => _EmailCheckState();
}

class _EmailCheckState extends State<EmailCheck> {
  late EmailCheckViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmailCheckViewModel>.reactive(
      viewModelBuilder: () => EmailCheckViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => PopScope(
        canPop: false,
        child: DefaultScaffold(
            busy: model.busy,
            showAppBarBackButton: false,
            body: Form(
              key: model.emailFormKey,
              onChanged: () => setState(() => model.isButtonEnabled =
                  model.emailFormKey.currentState!.validate()),
              autovalidateMode: AutovalidateMode.always,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Enter Your Email",
                            style: const TextStyle().titleMedium,
                          ).spaceTo(bottom: 30.h),
                        ),
                        CustomInputFields(
                          node: model.emailNode,
                          iconPresent: true,
                          controller: model.emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefix: ViewUtil.imageAsset4Scale(
                              asset: AppAssets.emailTextFdIcon),
                          hintText: "abc@email.com",
                          validate: (value) => model.emailNode.hasFocus
                              ? ValidationUtil.validateEmail(value)
                              : null,
                        ).spaceTo(bottom: 30.h),
                        ViewUtil.onboardingButton(
                                onPressed: !model.isButtonEnabled
                                    ? null
                                    : () async {
                                        model.checkEmail();
                                      },
                                buttonText: "CONTINUE")
                            .spaceTo(bottom: 30.h),
                        SizedBox(
                                // color: AppColors.ameSplashScreenBgColor,
                                height: 27.h,
                                width: 105.w)
                            .spaceSymmetrically(vertical: 40.h),
                        const Text(
                          "OR",
                          style: TextStyle(color: Colors.grey),
                        ).spaceTo(bottom: 10.h),
                        ViewUtil.customButton(
                                onPressed: () {},
                                buttonColor: Colors.white,
                                buttonLogo: AppAssets.googleLogo,
                                textColor: AppColors.typographyTitle,
                                buttonText: "Log in with Google")
                            .spaceTo(bottom: 60.h),
                      ],
                    ).spaceSymmetrically(horizontal: 16, vertical: 24),
                    ViewUtil.bonakoTrademark(),
                  ],
                ).spaceSymmetrically(vertical: 20),
              ),
            )),
      ),
    );
  }
}
