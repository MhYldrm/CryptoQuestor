import 'package:crypto_questor/core/components/button/my_custom_button.dart';
import 'package:crypto_questor/core/extension/my_extensions.dart';
import 'package:crypto_questor/core/components/styles/custom_colors.dart';
import 'package:crypto_questor/view/screens/sign_up_page.dart';
import 'package:crypto_questor/view/widgets/empty_widget.dart';
import 'package:crypto_questor/view/widgets/wallet_image_widgets.dart';
import 'package:flutter/material.dart';
import '../../core/services/firebase_service.dart';
import 'intro_page.dart';



class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String name, email, password;
  final formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;
  @override
  Widget build(BuildContext context) {
    double myWidht = MediaQuery.sizeOf(context).width;
    return Form(
      key: formKey,
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: CustomColors.bgcolor,
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
                      emailField(myWidht),
                      EmptyWidget(value: 20),
                      passwordField(myWidht),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomButton(onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          final result = await FirebaseService().signIn(email, password);
                          if (result == "success") {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const IntroPage()));
                          } else {
                            buildErrorShowDialog(result);
                          }
                        }
                      },
                        textName: context.mLocalizations.login,
                      ),
                      BuildBottomWidget(widht: myWidht/10)
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }


  // if login failed or something error
  Future<dynamic> buildErrorShowDialog(String? result) {
    return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: CustomColors.bgcolor,
                      title:  Text(
                        context.mLocalizations.error,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mYellow),
                      ),
                      content: Text(
                        result!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mWhitePrimary),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child:  Text(
                              context.mLocalizations.tryAgain,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.mYellow),
                            )),
                      ],
                    );
                  });
  }

  // Email and Password TextField
  Padding passwordField(double widht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.mYellow,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: CustomColors.mYellow,
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
            prefixIcon: const Icon(
              Icons.key,
              size: 30,
              color: CustomColors.mPurple,
            ),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisibility = !passwordVisibility;
                  });
                },
                icon: Icon(
                  passwordVisibility
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: CustomColors.mPurple,
                )),
            hintText: context.mLocalizations.password,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
          ),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
          obscuringCharacter: '*',
          obscureText: passwordVisibility,
          validator: (value) {
            if (value!.isEmpty) {
              return context.mLocalizations.cannotEmpty;
            } else {}
            return null;
          },
          onSaved: (value) {
            password = value!;
          },
        ),
      ),
    );
  }
  Padding emailField(double widht) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widht / 10.5),
      child: Container(
        decoration: BoxDecoration(
            color: CustomColors.mYellow,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: CustomColors.mYellow,
            )),
        child: TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            errorStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
            prefixIcon: const Icon(
              Icons.mail_outline_rounded,
              size: 30,
              color: CustomColors.mPurple,
            ),
            hintText: context.mLocalizations.email,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mBlackPrimary),
          ),
          keyboardType: TextInputType.emailAddress,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.mPurple),
          validator: (value) {
            if (value!.isEmpty) {
              return context.mLocalizations.cannotEmpty;
            } else {}
            return null;
          },
          onSaved: (value) {
            email = value!;
          },
        ),
      ),
    );
  }
}

// -don't have an a account- part widget
class BuildBottomWidget extends StatelessWidget {
  final double widht;
  const BuildBottomWidget({
    required this.widht,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: widht),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            context.mLocalizations.isNotHaveAccount,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: CustomColors.mGreyPrimary),
          ),
          const SizedBox(width: 10,),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const SignUpPage()));
              },
              child:  Text(
                context.mLocalizations.signUp,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: CustomColors.mYellow),
              ))
        ],
      ),
    );
  }
}

