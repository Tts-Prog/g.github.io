import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:ame/views/reset_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/app_assets.dart';
import '../../resources/utilities/textfields/custom_text_fields.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import 'password_reset_view_model.dart';

class PasswordEmail extends StatefulWidget {
  const PasswordEmail({Key? key, required this.email}) : super(key: key);
  static String routeName = "/insurance";
  final String email;

  @override
  State<PasswordEmail> createState() => _PasswordEmailState();
}

class _PasswordEmailState extends State<PasswordEmail> {
  late PasswordResetViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PasswordResetViewModel>.reactive(
      viewModelBuilder: () => PasswordResetViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init2(context, widget.email);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: Form(
            key: model.emailFormKey,
            onChanged: () => setState(() => model.isEmailButtonEnabled =
                model.emailFormKey.currentState!.validate()),
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reset your password",
                      style: const TextStyle().titleMedium,
                    ).spaceTo(bottom: 20.h),
                  ),
                  Text(
                    "Please enter your email address to request a password reset",
                    style: const TextStyle().bodyMedium,
                  ).spaceTo(bottom: 20.h),
                  CustomInputFields(
                    node: model.emailNode,
                    controller: model.emailController,
                    iconPresent: true,
                    keyboardType: TextInputType.emailAddress,
                    prefix: ViewUtil.imageAsset4Scale(
                        asset: AppAssets.emailTextFdIcon),
                    hintText: "abc@email.com",
                  ).spaceTo(bottom: 20.h),
                  ViewUtil.onboardingButton(
                      buttonText: "SEND",
                      onPressed: !model.isEmailButtonEnabled
                          ? null
                          : () {
                              model.checkEmail();
                            })
                ],
              ).spaceSymmetrically(horizontal: 20, vertical: 24),
            ),
          )),
    );
  }
}
