import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/textfields/custom_text_fields.dart';
import 'package:ame/resources/utilities/textfields/password_form_field.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:ame/views/reset_password/email.dart';
import 'package:ame/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/validation_util.dart';

import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'sign_in_view_model.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.email}) : super(key: key);
  static String routeName = "/insurance";
  final String email;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late SignInViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context, widget.email);
        model.fillEmail(widget.email);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                        // color: AppColors.ameSplashScreenBgColor,
                        height: 27.h,
                        width: 105.w)
                    .spaceSymmetrically(vertical: 40.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Log In",
                    style: const TextStyle().titleMedium,
                  ).spaceTo(bottom: 20.h),
                ),
                // CustomInputFields(
                //   node: model.emailNode,
                //   readOnly: true,
                //   iconPresent: true,
                //   controller: model.emailController,
                //   keyboardType: TextInputType.emailAddress,
                //   prefix: ViewUtil.imageAsset4Scale(
                //       asset: AppAssets.emailTextFdIcon),
                //   labelText: "abc@email.com",
                // ).spaceTo(bottom: 20.h),
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
                PasswordTextField(
                  keyboardType: TextInputType.text,
                  hintText: "Your Password",
                  controller: model.passwordController,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordEmail(
                                  email: widget.email,
                                )),
                      );
                    },
                    child: Text(
                      "Recover Password",
                      textAlign: TextAlign.end,
                      style: const TextStyle().bodyMedium,
                    ).spaceTo(bottom: 20.h, top: 20.h),
                  ),
                ),
                ViewUtil.onboardingButton(
                    buttonText: "SIGN IN",
                    onPressed: () async {
                      model.logIn();
                    }).spaceTo(bottom: 20.h, top: 20.h),

                const Text(
                  "OR",
                  style: TextStyle(color: Colors.grey),
                ).spaceTo(bottom: 10.h),

                ViewUtil.onboardingButton(
                  buttonText: "Create account",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(
                          email: widget.email,
                        ),
                      ),
                    );
                  },
                ).spaceTo(bottom: 20.h, top: 20.h),
                // ViewUtil.customButton(
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => SignUp(
                //                 email: widget.email,
                //               ),
                //             ),
                //           );
                //         },
                //         buttonColor: Colors.white,
                //         buttonLogo: AppAssets.googleLogo,
                //         textColor: AppColors.typographyTitle,
                //         buttonText: "Create new account")
                //     .spaceTo(bottom: 50.h),
                ViewUtil.bonakoTrademark()
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: 'Already have an account? ',
                //         style: const TextStyle().bodyMedium,
                //       ),
                //       const TextSpan(
                //         text: 'Sign In',
                //         style: TextStyle(
                //             fontFamily: AppFonts.lato,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold,
                //             color: AppColors.ameSplashScreenBgColor
                //             //decoration: TextDecoration.underline,
                //             ),
                //       ),
                //     ],
                //   ),
                // ).spaceTo(top: 50.h)
              ],
            ).spaceSymmetrically(horizontal: 20.w, vertical: 24),
          )),
    );
  }
}
