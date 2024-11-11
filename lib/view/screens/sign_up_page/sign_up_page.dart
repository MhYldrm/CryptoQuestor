import 'package:crypto_questor/core/components/button/my_custom_button.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/core/models/user_provider.dart';
import 'package:crypto_questor/view/screens/sign_up_page/mixin/form_fields_mixin.dart';
import 'package:crypto_questor/view/screens/sign_up_page/widget/block_chain_image_wigdets.dart';
import 'package:crypto_questor/view/screens/sign_up_page/widget/existing_account_link_widget.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:crypto_questor/view/widgets/project_decoration/project_input_decorations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/project_decoration/project_box_decorations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with FormFieldsMixin{
  final formKey = GlobalKey<FormState>();
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
              backgroundColor: CustomColors.bgcolor,
              body: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: BlockchainImageWidgets(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildNamePart(myWidht, userProvider, context),
                          const EmptyWidget(height: 30),
                          _buildEmailPart(myWidht, context, userProvider),
                          const EmptyWidget(height: 30),
                          _buildPasswordPart(myWidht, userProvider, context),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          MyCustomButton(
                            onPressed: () => signUp(context,formKey,userProvider),
                            buttonText: context.mLocalizations.signUp,
                          ),
                          ExistingAccountLinkWidget(widht: myWidht / 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
          );
        },
      ),
    );
  }

  Padding _buildNamePart(double myWidht, UserProvider userProvider, BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration:
        ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration: ProjectInputDecorations
              .signUpPageNameFieldInputDecoration(
              context),
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(context),
          validator: (value) => validateName(value, context),
          onSaved: (value) {
            userProvider.setUserData(name: value);
            },
        ),
      ),
    );
  }

  Padding _buildPasswordPart(double myWidht, UserProvider userProvider, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration: ProjectInputDecorations.signUpPasswordFieldInputDecoration(context),
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(context),
          validator: (value) => validatePassword(value, context),
          onSaved: (value) {
            userProvider.setUserData(password: value);
            },
        ),
      ),
    );
  }

  Padding _buildEmailPart(double myWidht, BuildContext context, UserProvider userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration: ProjectInputDecorations.signUpPageEmailFieldInputDecoration(context),
          keyboardType: TextInputType.emailAddress,
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(context),
          validator: (value) => validateEmail(value, context),
          onSaved: (value) {
            userProvider.setUserData(email: value);
            },
        ),
      ),
    );
  }
}
