import '../../../../product/components/project_decoration/project_input_decorations.dart';
import '../../../../product/components/styles/project_exports.dart';
import '../../../view_models/user_view_model.dart';
import '../sign_in_page.dart';

mixin SignInPageMixin on State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  /// [buildPasswordPart] builds the password input section for the sign-in form.
  Padding buildPasswordPart(
      double myWidht, BuildContext context, UserViewModel userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration: ProjectInputDecorations.signInPagePasswordFieldWithVisibilityInputDecoration(
              context, passwordVisibility, togglePasswordVisibility),
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(context),
          obscuringCharacter: ProjectConstants.obscuringCharacter,
          obscureText: passwordVisibility,
          validator: (value) => validatePassword(value, context), // Password validation
          onSaved: (value) {
            userProvider.setUserData(
              password: value,
            ); // Save the password to the provider
          },
        ),
      ),
    );
  }

  /// [ buildEmailPart] builds the email input section for the sign-in form.
  Padding buildEmailPart(double myWidht, BuildContext context, UserViewModel userProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: myWidht / 10.5),
      child: Container(
        decoration: ProjectBoxDecorations.signPagesBoxDecoration,
        child: TextFormField(
          decoration:
              ProjectInputDecorations.signInPageEmailFieldInputDecoration(context),
          keyboardType: TextInputType.emailAddress,
          style: ProjectInputDecorations.signPagesInputDecorationTextStyle(context),
          validator: (value) => validateEmail(value, context), // Email validation
          onSaved: (value) {
            userProvider.setUserData(
              email: value,
            ); // Save the email to the provider
          },
        ),
      ),
    );
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
