library sign_up_page;

import 'package:crypto_questor/feature/view/sign_up_page/widget/existing_account_link_widget.dart';
import 'package:crypto_questor/feature/view/sign_up_page/widget/sign_show_error_dialog_widget.dart';
import 'package:provider/provider.dart';
import 'package:crypto_questor/product/components/styles/project_exports.dart';
import '../../../product/components/styles/project_sizes.dart';
import '../../view_models/user_view_model.dart';
import '../sign_in_page/sign_in_page.dart';
import 'mixin/sign_up_page_mixin.dart';

/// [SignUpPage] is the screen where new users can register by providing their details.
///
/// ### Key Responsibilities:
/// - Displays fields for entering the user's name, email, and password.
/// - Uses form validation to ensure the inputs are correct.
/// - Allows users to sign up using the [ProjectCustomButton] widget.
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
/// - [ProjectCustomButton] is used to trigger the sign-up process.
/// - [ExistingAccountLinkWidget] provides a link to navigate to the sign-in page.
///
part 'widget/block_chain_image_wigdets.dart';
part 'widget/user_created_snackbar_widget.dart';
part 'mixin/sign_up_form_fields_mixin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SignUpFormFieldsMixin, SignUpPageMixin {
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
              body: Padding(
                padding: const ProjectPaddings.topLarge(),
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
                          buildNamePart(
                            context.deviceWidht,
                            userProvider,
                            context,
                          ),
                          EmptyWidget(height: ProjectSizes.size30.value),
                          buildEmailPart(
                            context.deviceWidht,
                            context,
                            userProvider,
                          ),
                          EmptyWidget(height: ProjectSizes.size30.value),
                          buildPasswordPart(
                            context.deviceWidht,
                            userProvider,
                            context,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          ProjectCustomButton(
                            onPressed: () => signUp(context, formKey, userProvider),
                            buttonText: context.mLocalizations.signUp,
                          ),
                          ExistingAccountLinkWidget(
                            widht: context.deviceWidht / 10,
                          ),
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
}
