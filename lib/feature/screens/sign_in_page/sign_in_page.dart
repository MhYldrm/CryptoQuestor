import 'package:crypto_questor/feature/screens/sign_in_page/widget/forgot_password_widget.dart';
import 'package:crypto_questor/feature/screens/sign_in_page/widget/sign_up_link_widget.dart';
import 'package:crypto_questor/feature/screens/sign_in_page/widget/wallet_image_widgets.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../../../product/components/button/my_custom_button.dart';
import '../../../product/components/project_decoration/project_box_decorations.dart';
import '../../../product/components/project_decoration/project_input_decorations.dart';
import '../../../product/models/user_provider.dart';
import '../../widgets/empty_widget.dart';
import 'mixin/sign_in_form_fields_mixin.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInFormFieldsMixin {
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    double myWidht = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.all(0.1),
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          return Form(
            key: formKey,
            child: SafeArea(
                child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: context.projectTheme!.primaryColor,
              body: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: WalletImageWidgets(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEmailPart(myWidht, context, userProvider),
                        const EmptyWidget(height: 20),
                        _buildPasswordPart(myWidht, context, userProvider),
                        const ForgotPasswordWidget(),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyCustomButton(
                          onPressed: () =>
                              signIn(context, formKey, userProvider),
                          buttonText: context.mLocalizations.login,
                        ),
                        SignUpLinkWidget(widht: myWidht / 10),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          );
        },
      ),
    );
  }

  Padding _buildEmailPart(
      double myWidht, BuildContext context, UserProvider userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration:
              ProjectInputDecorations.signInPageEmailFieldInputDecoration(
                  context),
          keyboardType: TextInputType.emailAddress,
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(
              context),
          validator: (value) => validateEmail(value, context),
          onSaved: (value) {
            userProvider.setUserData(email: value);
          },
        ),
      ),
    );
  }

  Padding _buildPasswordPart(
      double myWidht, BuildContext context, UserProvider userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration: ProjectInputDecorations
              .signInPagePasswordFieldWithVisibilityInputDecoration(
                  context, passwordVisibility, togglePasswordVisibility),
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(
              context),
          obscuringCharacter: '*',
          obscureText: passwordVisibility,
          validator: (value) => validatePassword(value, context),
          onSaved: (value) {
            userProvider.setUserData(password: value);
          },
        ),
      ),
    );
  }
}
