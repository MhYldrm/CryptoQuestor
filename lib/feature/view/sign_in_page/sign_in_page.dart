library sign_in_page;

import 'package:crypto_questor/product/components/styles/project_sizes.dart';
import 'package:provider/provider.dart';
import 'package:crypto_questor/product/components/styles/project_exports.dart';
import '../../view_models/user_view_model.dart';
import '../intro_page/intro_page.dart';
import '../sign_up_page/sign_up_page.dart';
import '../sign_up_page/widget/sign_show_error_dialog_widget.dart';
import 'mixin/forgot_password_widget_mixin.dart';
import 'mixin/sign_in_page_mixin.dart';

/// The [SignInPage] widget is a form-based page where users can sign into their account.
///
/// This page includes:
/// - A section for the user to enter their email address.
/// - A section for the user to enter their password with an option to toggle visibility.
/// - A button to submit the form for authentication.
/// - A link to the sign-up page and a link for password reset.
///
/// ### Key Responsibilities:
/// - Handles user authentication through email and password input fields.
/// - Displays a sign-in button to authenticate the user.
/// - Provides options to reset the password or navigate to the sign-up page.
///
/// ### State Management:
/// - Uses [UserProvider] to store user data (e.g., email, password).
/// - The form input is validated and saved into the provider for authentication.
///
/// ### Widgets:
/// - [WalletImageWidgets] displays a relevant image for wallet or crypto theme.
/// - [ProjectCustomButton] triggers the sign-in action.
/// - [SignUpLinkWidget] provides a link to the sign-up page.
/// - [ForgotPasswordWidget] allows the user to reset their password.
///
part 'widget/forgot_password_widget.dart';
part 'widget/sign_up_link_widget.dart';
part 'widget/wallet_image_widgets.dart';
part 'mixin/sign_in_form_fields_mixin.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInFormFieldsMixin,SignInPageMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.1),
      child: Consumer<UserViewModel>(
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
                      child: WalletImageWidgets(),),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Email input field
                          buildEmailPart(context.deviceWidht, context, userProvider),
                          EmptyWidget(height: ProjectSizes.size20.value),
                          // Password input field
                          buildPasswordPart(context.deviceWidht, context, userProvider),
                          const ForgotPasswordWidget(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Sign In button
                          ProjectCustomButton(
                            onPressed: () =>
                                signIn(context, formKey, userProvider),
                            buttonText: context.mLocalizations.login,
                          ),
                          SignUpLinkWidget(widht: context.deviceWidht / 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
