library login;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kro_banking/bloc/authentication/authentication_bloc.dart';
import 'package:kro_banking/constants/app_constants.dart';
import 'package:kro_banking/extentions/on_context.dart';
import 'package:kro_banking/mixins/validation.dart';
import 'package:kro_banking/theme/app_colors.dart';
import 'package:kro_banking/theme/app_images.dart';
import 'package:kro_banking/widgets/buttons/app_elevated_button.dart';
import 'package:kro_banking/widgets/inputs/app_text_imput.dart';
import 'package:kro_banking/widgets/overlay/loading_overlay.dart';
import 'package:responsive_builder/responsive_builder.dart';

part 'constants/strings.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context
        .read<AuthenticationBloc>()
        .loginWithEmailPassword(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: _buildLogin(),
    );
  }

  Positioned _buildLogin() {
    return Positioned.fill(child: ResponsiveBuilder(builder: (context, device) {
      return Row(
        children: [
          if (!device.isMobile) _buildContactSection(context),
          Expanded(
              flex: device.isTablet ? 7 : 5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: context.pHeight(50)),
                color: context.theme.scaffoldBackgroundColor,
                child: Column(
                  children: [
                    _buildGoToWebsite(),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.kBgWhite,
                          borderRadius: BorderRadius.circular(10)),
                      margin:
                          EdgeInsets.symmetric(horizontal: context.pWidth(130)),
                      child: LoadingOverlay(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.pWidth(20),
                              vertical: context.pHeight(40)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                KStrings.welcomeBack,
                                style: context.textTheme.titleLarge,
                              ),
                              const Divider(),
                              SizedBox(
                                height: 1.sh,
                              ),
                              Form(
                                  key: _formKey,
                                  child: AutofillGroup(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AppTextInput(
                                          validator: emailValidation,
                                          autofillHints: const [
                                            AutofillHints.email,
                                          ],
                                          controller: emailController,
                                          title: KStrings.emailAddress),
                                      SizedBox(
                                        height: 1.sh,
                                      ),
                                      AppTextInput(
                                          autofillHints: const [
                                            AutofillHints.password,
                                          ],
                                          isPasswordField: true,
                                          titleAction: GestureDetector(
                                              onTap: () {
                                                //TODO:implement this
                                              },
                                              child: const Text(
                                                  KStrings.forgetPassword)),
                                          controller: passwordController,
                                          title: KStrings.password),
                                      SizedBox(
                                        height: 2.sh,
                                      ),
                                      AppElevatedButton(
                                          onPressed: onLogin,
                                          title: KStrings.login),
                                      SizedBox(
                                        height: 2.sh,
                                      ),
                                      RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: const TextStyle(),
                                            children: <TextSpan>[
                                              const TextSpan(
                                                  text: KStrings.mewTo),
                                              TextSpan(
                                                text: KStrings.signUp,
                                                style: TextStyle(
                                                    color: context
                                                        .colorScheme.primary),
                                              ),
                                            ],
                                          ))
                                    ],
                                  )))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          [KStrings.email, KStrings.phoneNumber].map((itee) {
                        return TextButton(
                            onPressed: () {
                              //TODO:implement this
                            },
                            child: Text(itee));
                      }).toList(),
                    )
                  ],
                ),
              ))
        ],
      );
    }));
  }

  TextButton _buildGoToWebsite() {
    return TextButton(
        onPressed: () {
          // TODO: implement this
        },
        child: const Text(KStrings.goToWebsite));
  }

  Expanded _buildContactSection(BuildContext context) {
    return Expanded(
        flex: 6,
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: context.pHeight(50)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    KStrings.contactPrompt1,
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    KStrings.contactPrompt2,
                    style: context.textTheme.titleMedium,
                  ),
                  Wrap(
                    // mainAxisSize: MainAxisSize.max,
                    runAlignment: WrapAlignment.center,
                    children: [
                      (FontAwesomeIcons.envelope, KStrings.email),
                      (FontAwesomeIcons.phone, KStrings.phoneNumber)
                    ]
                        .map((item) => TextButton.icon(
                              onPressed: () {
                                // TODO:implement this
                              },
                              label: Text(item.$2),
                              icon: Icon(item.$1),
                            ))
                        .toList(),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FontAwesomeIcons.facebook,
                      FontAwesomeIcons.instagram,
                      FontAwesomeIcons.x,
                    ]
                        .map((item) => IconButton(
                              onPressed: () {
                                // TODO:implement this
                              },
                              icon: Icon(item),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Positioned _buildBackground() {
    return Positioned.fill(
      child: SvgPicture.asset(
        AppImages.kLoginBg,
        fit: BoxFit.cover,
      ),
    );
  }
}
