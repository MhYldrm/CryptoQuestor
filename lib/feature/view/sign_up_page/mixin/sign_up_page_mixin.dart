import 'package:crypto_questor/product/components/styles/project_exports.dart';
import '../../../../product/components/project_decoration/project_input_decorations.dart';
import '../../../view_models/user_view_model.dart';
import '../sign_up_page.dart';

mixin SignUpPageMixin on State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  /// [buildNamePart] builds the name input section for the user to enter their name.
  Padding buildNamePart(
    double myWidht,
    UserViewModel userProvider,
    BuildContext context,
  ) {
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

  /// [buildPasswordPart] builds the password input section for the user to enter their password.
  Padding buildPasswordPart(double myWidht, UserViewModel userProvider, BuildContext context) {
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

  /// [buildEmailPart] builds the email input section for the user to enter their email.
  Padding buildEmailPart(double myWidht, BuildContext context, UserViewModel userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration:
              ProjectInputDecorations.signUpPageEmailFieldInputDecoration(context),
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

  String? validateName(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.mLocalizations.nameCannotBeEmpty;
    }
    return null;
  }

  String? validateEmail(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.mLocalizations.emailCannotBeEmpty;
    }
    return null;
  }

  String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.mLocalizations.passwordCannotBeEmpty;
    }
    return null;
  }
}
