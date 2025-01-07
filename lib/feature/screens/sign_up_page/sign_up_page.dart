import 'package:crypto_questor/feature/screens/sign_up_page/widget/block_chain_image_wigdets.dart';
import 'package:crypto_questor/feature/screens/sign_up_page/widget/existing_account_link_widget.dart';
import 'package:crypto_questor/product/extension/my_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../product/components/button/my_custom_button.dart';
import '../../../product/components/project_decoration/project_box_decorations.dart';
import '../../../product/components/project_decoration/project_input_decorations.dart';
import '../../providers/user_provider.dart';
import '../../widgets/empty_widget.dart';
import 'mixin/sign_up_form_fields_mixin.dart';

/// [SignUpPage] is the screen where new users can register by providing their details.
///
/// ### Key Responsibilities:
/// - Displays fields for entering the user's name, email, and password.
/// - Uses form validation to ensure the inputs are correct.
/// - Allows users to sign up using the [MyCustomButton] widget.
/// - Includes a link to the existing account page via [ExistingAccountLinkWidget].
///
/// ### State Management:
/// - Uses [UserProvider] to manage the user's data (e.g., email, name, password).
/// - [SignUpPage] utilizes [UserProvider] to handle user input and store data for the sign-up process.
///
/// ### Mixins:
/// - Implements [SignUpFormFieldsMixin] to provide validation and input handling logic.
///
/// ### Widgets:
/// - [BlockchainImageWidgets] displays relevant images about blockchain technology.
/// - [MyCustomButton] is used to trigger the sign-up process.
/// - [ExistingAccountLinkWidget] provides a link to navigate to the sign-in page.
///

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpFormFieldsMixin {
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
                  backgroundColor: context.projectTheme!.primaryColor,
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
                                onPressed: () => signUp(context, formKey, userProvider),
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

  /// [_buildNamePart] builds the name input section for the user to enter their name.
  Padding _buildNamePart(double myWidht, UserProvider userProvider, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration: ProjectInputDecorations.signUpPageNameFieldInputDecoration(context),
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(context),
          validator: (value) => validateName(value, context),
          onSaved: (value) {
            userProvider.setUserData(name: value);
          },
        ),
      ),
    );
  }

  /// [_buildPasswordPart] builds the password input section for the user to enter their password.
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

  /// [_buildEmailPart] builds the email input section for the user to enter their email.
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
