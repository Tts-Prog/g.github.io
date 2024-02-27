import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/textfields/password_form_field.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import 'password_reset_view_model.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  late PasswordResetViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PasswordResetViewModel>.reactive(
      viewModelBuilder: () => PasswordResetViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reset Password",
                      style: const TextStyle().titleMedium,
                    ).spaceTo(bottom: 20.h),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Please enter your new password",
                      style: const TextStyle().bodyMedium,
                    ).spaceTo(bottom: 20.h),
                  ),
                  PasswordTextField(
                    keyboardType: TextInputType.text,
                    labelText: "Your Password",
                    controller: model.passwordController,
                  ).spaceTo(bottom: 20.h),
                  PasswordTextField(
                    keyboardType: TextInputType.text,
                    labelText: "Confirm Password",
                    controller: model.confirmPwordController,
                  ).spaceTo(bottom: 20.h),
                  ViewUtil.onboardingButton(
                      buttonText: "LOG IN",
                      onPressed: () async {
                        model.changePassword();
                      })
                ],
              ).spaceSymmetrically(horizontal: 16, vertical: 24),
              ViewUtil.bonakoTrademark()
            ],
          ).spaceSymmetrically(vertical: 20)),
    );
  }
}

//Please enter your email address to request a password reset
